import 'package:flutter/material.dart';
import 'package:sales_officer/DistributorList/DistributorList.dart';
import 'package:shimmer/shimmer.dart';

class DistributorListSkeleton extends StatelessWidget {
  final int index;

  DistributorListSkeleton(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      alignment: Alignment.centerLeft,
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 2),
            blurRadius: 3,
          ),
        ],
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
      ),
      child: Shimmer(
        gradient: LinearGradient(colors: [Colors.white, Colors.grey]),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors[index],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                color: Colors.blue,
                height: 10,
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
