import 'package:flutter/material.dart';
import 'package:snap_sample/constants/default_sizes.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: DfSizes.large,
      right: DfSizes.medium,
      child: Container(
          padding: const EdgeInsets.all(8),
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
          child: const Icon(Icons.person_outlined)),
    );
  }
}
