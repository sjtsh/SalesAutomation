import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/method.dart';
import '../../Database.dart';

class Online extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 6, bottom: 6),
          clipBehavior: Clip.hardEdge,
          height: 58,
          width: 58,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white,width: 5),
            color: Color(0xff00000)
          ),
          child: Center(
            child: Text(
              getInitials(meSO!.SOName),
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
        Positioned(
          bottom: 3,
          right: -3,
          child: Container(
            height: 25,
            width: 25,
            child: Image.asset(
              "assets/BestEmployeeTrophy.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
