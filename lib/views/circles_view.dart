import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class CirclesView extends StatelessWidget {
  final List<Widget> circlesList;
  final int circleSizeEnlargement;

  CirclesView({required this.circlesList, required this.circleSizeEnlargement});

  //list of circles in different sizes
  List<Widget> getList() {
    //check if list is isEmpty
    if (circlesList.isEmpty) {
      for (var i = 1; i <= 6; i++) {
        circlesList.add(DottedBorder(
          dashPattern: const [5, 5],
          strokeWidth: 1,
          strokeCap: StrokeCap.round,
          color: Colors.black12,
          borderType: BorderType.Circle,
          child: Container(
            height: i.toDouble() * circleSizeEnlargement,
            width: i.toDouble() * circleSizeEnlargement,
            color: Colors.transparent,
          ),
        ));
      }
    }
    return circlesList;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: getList(),
      alignment: Alignment.center,
    );
  }
}
