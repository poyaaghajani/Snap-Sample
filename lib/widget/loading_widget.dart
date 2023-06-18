import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpinKitDoubleBounce(
      size: 35,
      color: Color.fromARGB(255, 2, 207, 36),
    );
  }
}
