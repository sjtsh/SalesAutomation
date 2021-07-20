import 'package:flutter/material.dart';
import 'package:sales_officer/ConfirmationScreen/ConfirmationReciept.dart';
import 'package:sales_officer/Header/Header.dart';
import 'package:sales_officer/Header/HeaderProductVariationPage.dart';
import 'package:sales_officer/NewOrder/NewOrder.dart';

class ConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            HeaderProductVariationPage(6),
            Container(
              padding: EdgeInsets.only(left: 12),
              alignment: Alignment.centerLeft,
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.black.withOpacity(0.1),
                  ),
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    "Distributor",
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
                        currentDistributor.split(" ")[0].substring(0, 1) +
                            currentDistributor.split(" ")[1].substring(0, 1),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      currentDistributor,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
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
            ),
            Expanded(
              child: ConfirmationReciept(),
            ),
          ],
        ),
      ),
    );
  }
}
