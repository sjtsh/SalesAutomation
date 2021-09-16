import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/TourPlanScreen/TourPlanScreen.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: Offset(0, 2))
              ],
            ),
            child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return TourPlanScreen();
                  }));
                },
                child: Container(
                  height: 70,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      Icon(
                        Icons.tour,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(child: Text("Create Tour Plan")),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
