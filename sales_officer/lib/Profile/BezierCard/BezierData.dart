import 'package:flutter/material.dart';
import 'package:sales_officer/Database.dart';

class BezierData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, int index) => Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, right: 8, left: 8, bottom: 2),
          child: Row(
            children: [
              Text(
                "${index + 1}",
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  products[index],
                ),
              ),
              Text(
                "Rs. ${sales[index]}",
              )
            ],
          ),
        ),
      ),
    );
  }
}
