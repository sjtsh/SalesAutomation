import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/SKU.dart';
import 'package:sales_officer/BACKEND/Methods/createOrder.dart';
import 'package:sales_officer/BACKEND/Services/DistributorReturnOrderItemService.dart';
import 'package:sales_officer/BACKEND/Services/DistributorReturnOrderService.dart';
import 'package:sales_officer/SignIn/SignIn.dart';


void main() {
  runApp(Fusers());
}

class Fusers extends StatefulWidget {
  @override
  _FusersState createState() => _FusersState();
}

class _FusersState extends State<Fusers> {
  @override
  Widget build(BuildContext context) {
    // DateTime rightNow = DateTime.now();
    // createReturnOrder(5, [SKU(3, "asd", 4, 2, "kg", 3, "g", 3, "carton", 4, "testing", 3, "")], context);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'Fusers',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: SignIn(),
      ),
    );
  }
}