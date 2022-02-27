import 'package:flutter/material.dart';

class RingAnimation extends StatelessWidget {
  final int dataNumber;
  final int ratioRingAndCircles;
  final int circleSizeEnlargement;

  RingAnimation(
      {required this.dataNumber,
      required this.ratioRingAndCircles,
      required this.circleSizeEnlargement});

  //calc ring enlargement
  double get _ringWidthAndHeight {
    return ((dataNumber.toDouble() / ratioRingAndCircles) *
        circleSizeEnlargement);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      // Use the properties stored in the State class.
      width: _ringWidthAndHeight,
      height: _ringWidthAndHeight,
      decoration: BoxDecoration(
        border: Border.all(
          width: 10,
          color: Colors.blue,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(300),
      ),
      curve: Curves.decelerate,
    );
  }
}
