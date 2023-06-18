import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MarkerIcons {
  MarkerIcons._();

  static Widget markerIcon = SvgPicture.asset(
    'assets/images/origin.svg',
    height: 120,
    width: 45,
  );

  static Widget originIcon = SvgPicture.asset(
    'assets/images/origin.svg',
    height: 120,
    width: 45,
  );

  static Widget desIcon = SvgPicture.asset(
    'assets/images/destination.svg',
    height: 120,
    width: 45,
  );
}
