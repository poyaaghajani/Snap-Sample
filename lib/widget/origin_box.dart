import 'package:flutter/material.dart';
import 'package:snap_sample/constants/default_sizes.dart';
import 'package:snap_sample/constants/default_styles.dart';

class OriginBox extends StatelessWidget {
  const OriginBox({super.key, required this.originAddress});

  final String originAddress;

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
              'مبدا: $originAddress',
              style: DfStyles.small,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(width: DfSizes.small),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2.5,
                  color: const Color.fromARGB(255, 2, 207, 36),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
