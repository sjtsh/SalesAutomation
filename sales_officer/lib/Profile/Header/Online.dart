import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/method.dart';
import '../../Database.dart';

class Online extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 12,bottom: 6),
         clipBehavior: Clip.hardEdge,
          height:75,
          width: 68,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
          ),
          child: Center(
            child: Text(
              getInitials(meSO!.SOName),
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
        // Positioned(
        //   bottom: 6,
        //   right: 2,
        //   child: Container(
        //     height: 15,
        //     width: 15,
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       color: Colors.green,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
