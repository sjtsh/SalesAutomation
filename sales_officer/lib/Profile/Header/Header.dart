import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/Profile/Header/Online.dart';

import 'ProgressBar.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 12.0,
        left: 12,
        bottom: 6,
      ),
      child: Container(
        height: 70,
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
                      "John Doe",
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
                  "Kritipur Beat",
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
    );
  }
}
