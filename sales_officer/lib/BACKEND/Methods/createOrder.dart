import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND/Services/DistributorOrderItemService.dart';
import 'package:sales_officer/BACKEND/Services/DistributorOrderService.dart';

import '../../Database.dart';

Future<void> createOrder(int distributorID,
    List<TextEditingController> _textEditingControllers, context) async {
  bool conditionOnly = true;
  int _distributorID = distributorID;
  int _SOID = 1;
  bool _joint = false;
  bool _orderStatus = true;
  String _remarks = "Success";
  String _dateAndTime = DateTime.now().toString();
  DistributorOrderService distributorOrderService = DistributorOrderService();
  distributorOrderService
      .insertDistributorOrder(
          _distributorID, _SOID, _joint, _orderStatus, _remarks, _dateAndTime)
      .then((value) async {
    int distributorOrderID = value;
    _textEditingControllers.forEach(
      (element) async {
        if (_textEditingControllers.indexOf(element) % 2 == 0) {
          int SKUID =
              allSKULocal[_textEditingControllers.indexOf(element) ~/ 2].SKUID;
          int primaryItemCount = 0;
          int alternativeItemCount = 0;
          int secondaryAlternativeItemCount = 0;
          if (element.text != "") {
            primaryItemCount = int.parse(element.text);
          }
          if (_textEditingControllers[
                      _textEditingControllers.indexOf(element) + 1]
                  .text !=
              "") {
            alternativeItemCount = int.parse(_textEditingControllers[
                    _textEditingControllers.indexOf(element) + 1]
                .text);
          }
          if (primaryItemCount != 0 || alternativeItemCount != 0) {
            DistributorOrderItemService distributorOrderItemService =
                DistributorOrderItemService();
            bool condition2 =
                await distributorOrderItemService.insertDistributorOrderItem(
                    distributorOrderID,
                    SKUID,
                    primaryItemCount,
                    alternativeItemCount,
                    secondaryAlternativeItemCount);
            if (!condition2) {
              conditionOnly = false;
            }
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
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Order was not successful")));
      return false;
    }
  });
}
