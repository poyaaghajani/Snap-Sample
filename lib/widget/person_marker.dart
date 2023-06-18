import 'package:flutter/material.dart';

class PersonMarker extends StatelessWidget {
  const PersonMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const SizedBox(
          width: 100,
          height: 100,
        ),
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff3B5EDF),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Color(0xff3B5EDF),
                  offset: Offset(0, 0),
                ),
              ]),
        ),
        Container(
          width: 25,
          height: 25,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
