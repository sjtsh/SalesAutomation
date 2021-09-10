import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Methods/method.dart';
import 'package:sales_officer/DialogBox/DialogBox.dart';


class BreadCrum2 extends StatelessWidget {
  final String prefix;
  final String currentDistributor;

  BreadCrum2(this.prefix, this.currentDistributor);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text(
            prefix,
            style: TextStyle(fontSize: 12),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black.withOpacity(0.5),
              size: 12,
            ),
          ),
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffEA47B2),
            ),
            child: Center(
                child: Text(
                getInitials(currentDistributor),
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 8),
            )),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            currentDistributor,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class BreadCrum3 extends StatelessWidget {
  final String prefix;
  final String currentDistributor;

  BreadCrum3(this.prefix, this.currentDistributor);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          BreadCrum2(prefix, currentDistributor),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black.withOpacity(0.5),
              size: 12,
            ),
          ),
          Text(
            "Order Confirmation",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
