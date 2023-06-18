import 'package:flutter/material.dart';
import 'package:snap_sample/constants/default_sizes.dart';

class AppTheme {
  AppTheme._();

  static ThemeData appTheme = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        fixedSize: const MaterialStatePropertyAll(
          Size(double.infinity, 58),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DfSizes.medium),
          ),
        ),
        elevation: const MaterialStatePropertyAll(0),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return const Color.fromARGB(255, 0, 177, 29);
            }
            return const Color.fromARGB(255, 2, 207, 36);
          },
        ),
      ),
    ),
  );
}
