import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/Database.dart';
import 'package:sales_officer/Profile/Header/Online.dart';

import 'ProgressBar.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: ShapeDecoration(
            color: Color(0xffF5F5F5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: SizedBox(
            height: 200,
            width: 350,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Online(),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Row(
                        children: [
                          Text(
                            meSO!.SOName,
                            textAlign: TextAlign.left,
                            style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            " - lvl 5",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6), fontSize: 16),
                          ),
                        ],
                      ),
                      Text(
                        "Beat: $meBeat",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.4), fontSize: 14),
                      ),
                      ProgressBar(),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
