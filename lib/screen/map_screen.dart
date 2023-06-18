import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';
import 'package:snap_sample/constants/current_app_state.dart';
import 'package:snap_sample/constants/default_sizes.dart';
import 'package:snap_sample/constants/default_styles.dart';
import 'package:snap_sample/constants/marker_icons.dart';
import 'package:snap_sample/widget/back_widget.dart';
import 'package:snap_sample/widget/destination_box.dart';
import 'package:snap_sample/widget/distance_box.dart';
import 'package:snap_sample/widget/loading_widget.dart';
import 'package:snap_sample/widget/origin_box.dart';
import 'package:snap_sample/widget/person_marker.dart';
import 'package:snap_sample/widget/profile_widget.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // list of current state
  List currentStateList = [CurrentAppState.selectOrigineState];

  // list of selected geopoints
  List<GeoPoint> geoPoints = [];

  // map controller
  MapController mapController = MapController(
    initMapWithUserPosition: true,
  );

  // distance between 2 points
  String distance = 'درحال محاسبه فاصله...';

  // origin and destination address
  String originAddress = 'درحال محاسبه آدرس مبدا...';
  String desAddress = 'درحال محاسبه آدرس مقصد...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // flutter osm map
          SizedBox.expand(
            child: OSMFlutter(
              controller: mapController,
              userLocationMarker: UserLocationMaker(
                personMarker: const MarkerIcon(
                  iconWidget: PersonMarker(),
                ),
                directionArrowMarker: const MarkerIcon(
                  iconWidget: PersonMarker(),
                ),
              ),
              initZoom: 15,
              minZoomLevel: 8,
              maxZoomLevel: 18,
              isPicker: true,
              stepZoom: 1,
              mapIsLoading: const LoadingWidget(),
              markerOption: MarkerOption(
                advancedPickerMarker: MarkerIcon(
                  iconWidget: MarkerIcons.markerIcon,
                ),
              ),
            ),
          ),

          // back button
          if (currentStateList.last != CurrentAppState.selectOrigineState) ...[
            BackWidget(
              onPressed: () {
                setState(
                  () {
                    currentStateList.removeLast();

                    if (currentStateList.last ==
                        CurrentAppState.selectOrigineState) {
                      MarkerIcons.markerIcon = MarkerIcons.originIcon;
                      mapController.init();
                    } else {
                      MarkerIcons.markerIcon = MarkerIcons.desIcon;
                      mapController.zoomIn();
                    }
                    mapController.advancedPositionPicker();

                    if (geoPoints.isNotEmpty) {
                      mapController.removeMarker(geoPoints.last);
                      geoPoints.removeLast();
                    }
                  },
                );
              },
            ),
          ],

          // profile button
          const ProfileWidget(),

          // current widget
          currentWidget(),
        ],
      ),
    );
  }

  // curent widget
  Widget currentWidget() {
    Widget widget = originState();
    switch (currentStateList.last) {
      case CurrentAppState.selectOrigineState:
        widget = originState();
        break;
      case CurrentAppState.selectDestinationState:
        widget = destinationState();
        break;
      case CurrentAppState.requestDriverState:
        widget = reqDriverState();
        break;
    }
    return widget;
  }

  // select origin state
  Widget originState() {
    return Positioned(
      right: DfSizes.large,
      bottom: DfSizes.large,
      left: DfSizes.large,
      child: ElevatedButton(
        onPressed: () async {
          // get current position
          await getCurrentPosition();

          await mapController.addMarker(
            geoPoints.first,
            markerIcon: MarkerIcon(
              iconWidget: MarkerIcons.originIcon,
            ),
          );

          MarkerIcons.markerIcon = MarkerIcons.desIcon;

          mapController.init();

          setState(() {
            currentStateList.add(CurrentAppState.selectDestinationState);
          });
        },
        child: Text(
          'انتخاب مبدا',
          style: DfStyles.button,
        ),
      ),
    );
  }

  // slect destination state
  Widget destinationState() {
    return Positioned(
      right: DfSizes.large,
      bottom: DfSizes.large,
      left: DfSizes.large,
      child: ElevatedButton(
        onPressed: () async {
          mapController.enableTracking();

          // get current position
          await getCurrentPosition();

          mapController.cancelAdvancedPositionPicker();

          await mapController.addMarker(
            geoPoints.last,
            markerIcon: MarkerIcon(
              iconWidget: MarkerIcons.desIcon,
            ),
          );

          setState(() {
            currentStateList.add(CurrentAppState.requestDriverState);
          });

          // get distance between 2 points
          await getDistance();

          if (geoPoints.length >= 2) {
            mapController.zoomOut();
          }

          await getAddress();
        },
        child: Text(
          'انتخاب مقصد',
          style: DfStyles.button,
        ),
      ),
    );
  }

  // request driver state
  Widget reqDriverState() {
    return Positioned(
      right: DfSizes.large,
      bottom: DfSizes.large,
      left: DfSizes.large,
      child: Column(
        children: [
          // distance box
          DistanceBox(distance: distance),
          const SizedBox(height: DfSizes.small),

          // origin box
          OriginBox(originAddress: originAddress),
          const SizedBox(height: DfSizes.small),

          // destination box
          DestinationBox(desAddress: desAddress),
          const SizedBox(height: DfSizes.small),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'درخواست راننده',
                style: DfStyles.button,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // get current position
  getCurrentPosition() async {
    await mapController.getCurrentPositionAdvancedPositionPicker().then(
      (value) {
        geoPoints.add(value);
      },
    );
  }

  // get distance between 2 points
  getDistance() async {
    await distance2point(geoPoints.first, geoPoints.last).then((value) {
      setState(() {
        if (value < 1000) {
          distance = 'فاصله مبدا تا مقصد: ${value.toInt()} متر';
        } else {
          distance = 'فاصله مبدا تا مقصد: ${value ~/ 1000} کیلومتر';
        }
      });
    });
  }

  // get origin and destination address
  getAddress() async {
    try {
      await placemarkFromCoordinates(
              geoPoints.first.latitude, geoPoints.first.longitude,
              localeIdentifier: 'fa')
          .then(
        (List<Placemark> placeList) {
          var name = placeList[2].name;
          var locality = placeList[2].locality;

          setState(() {
            originAddress = name!.contains('منطقه') || name == locality
                ? '$locality ${placeList[1].name}'
                : '$locality $name';
          });
        },
      );

      await placemarkFromCoordinates(
              geoPoints.last.latitude, geoPoints.last.longitude,
              localeIdentifier: 'fa')
          .then(
        (List<Placemark> placeList) {
          var name = placeList[2].name;
          var locality = placeList[2].locality;

          setState(() {
            desAddress = name!.contains('منطقه') || name == locality
                ? '$locality ${placeList[1].name}'
                : '$locality $name';
          });
        },
      );
    } catch (ex) {
      setState(() {
        originAddress = 'آدرس مبدا یافت نشد';
        desAddress = 'آدرس مقصد یافت نشد';
      });
    }
  }
}
