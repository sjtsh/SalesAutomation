import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/method.dart';
import '../../Database.dart';

class Online extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          height: 58,
          width: 58,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
          ),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      getInitials(meSO!.SOName),
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        "assets/BestSOTrophy.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        "assets/BestEmployeeTrophy.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        "assets/BestPerformerTrophy.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                )
              ],
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
