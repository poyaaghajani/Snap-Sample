import 'package:flutter/material.dart';
import 'package:snap_sample/constants/default_sizes.dart';
import 'package:snap_sample/constants/default_styles.dart';

class DistanceBox extends StatelessWidget {
  const DistanceBox({super.key, required this.distance});

  final String distance;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DfSizes.medium),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DfSizes.small),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              distance,
              style: DfStyles.small,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(width: DfSizes.small),
            const Icon(
              Icons.route,
              color: Color.fromARGB(255, 2, 207, 36),
            ),
          ],
        ),
      ),
    );
  }
}
