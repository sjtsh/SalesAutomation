import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND/Services/DistributorOrderItemService.dart';
import 'package:sales_officer/BACKEND/Services/DistributorOrderService.dart';

import '../../Database.dart';

Future<bool> createOrder(int distributorID,
    List<TextEditingController> _textEditingControllers, context) async {
  bool conditionOnly = true;
  int _distributorID = distributorID;
  int _SOID = 1;
  bool _joint = false;
  bool _orderStatus = true;
  String _remarks = "Success";
  String _dateAndTime = DateTime.now().toString();
  DistributorOrderService distributorOrderService = DistributorOrderService();
  bool condition1 = await distributorOrderService.insertDistributorOrder(
      _distributorID, _SOID, _joint, _orderStatus, _remarks, _dateAndTime);
  print("inserting distributor order was " + condition1.toString());
  if(!condition1){
    conditionOnly = false;
  }
  List<DistributorOrder> distributorOrders =
  await distributorOrderService.fetchDistributorOrders();
  int distributorOrderID = distributorOrders
      .where((element) => element.SOID == _SOID)
      .last
      .distributorOrderID;
  _textEditingControllers.forEach(
        (element) async {
      if (element.text != "") {
        int SKUID = allSKULocal[_textEditingControllers.indexOf(element)].SKUID;
        int primaryItemCount = int.parse(element.text);
        int alternativeItemCount = 0;
        int secondaryAlternativeItemCount = 0;

        DistributorOrderItemService distributorOrderItemService = DistributorOrderItemService();
        bool condition2 = await distributorOrderItemService
            .insertDistributorOrderItem(
            distributorOrderID, SKUID, primaryItemCount, alternativeItemCount,
            secondaryAlternativeItemCount);
        print("inserting distributor order item was" + condition2.toString());
        if (!condition2) {
          conditionOnly = false;
        }
      }
    },
  );
  if (conditionOnly) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Order was successfully punched")));
    return true;
  }else {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Order was not successful")));
    return false;
  }
}
