import 'package:flutter/material.dart';
import 'package:snap_sample/constants/default_sizes.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({super.key, required this.onPressed});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: DfSizes.large,
      left: DfSizes.medium,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: 45,
          height: 45,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2, 3),
                blurRadius: 18,
              ),
            ],
          ),
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
