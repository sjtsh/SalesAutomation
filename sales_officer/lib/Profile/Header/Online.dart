import 'package:flutter/material.dart';

class Online extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
          child: Image.asset("assets/face.png"),
        ),
        Positioned(
          bottom: 6,
          right: 2,
          child: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}
