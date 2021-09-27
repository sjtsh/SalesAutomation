import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrderItem.dart';
import 'package:sales_officer/BACKEND/Entities/SKUStock.dart';
import 'package:sales_officer/BACKEND/Services/DistributorOrderItemService.dart';
import 'package:sales_officer/BACKEND/Services/DistributorOrderService.dart';
import 'package:sales_officer/BACKEND/Services/DistributorReturnOrderItemService.dart';
import 'package:sales_officer/BACKEND/Services/DistributorReturnOrderService.dart';
import 'package:sales_officer/BACKEND/Services/SKUStockService.dart';
import 'package:sales_officer/NavBar/NavBar.dart';

import '../../Database.dart';

Future<int> createOrder(int distributorID,
    List<TextEditingController> _textEditingControllers, bool isWarning) {
  int _distributorID = distributorID;
  int _SOID = meSO!.SOID;
  bool _joint = true;
  bool _orderStatus = !isWarning;
  String _remarks = "Success";
  String _dateAndTime = DateTime.now().toString();
  DistributorOrderService distributorOrderService = DistributorOrderService();
  Future<int> value = distributorOrderService
      .insertDistributorOrder(
          _distributorID, _SOID, _joint, _orderStatus, _remarks, _dateAndTime)
      .then((aCondition) {
    try {
      _textEditingControllers.forEach(
        (element) {
          if (_textEditingControllers.indexOf(element) % 2 == 0) {
            int SKUID =
                allSKULocal[_textEditingControllers.indexOf(element) ~/ 2]
                    .SKUID;
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
              distributorOrderItemService.insertDistributorOrderItem(
                  aCondition,
                  SKUID,
                  primaryItemCount,
                  alternativeItemCount,
                  secondaryAlternativeItemCount);
            }
          }
        },
      );
    } catch (e) {
      print("wasnt successful");
    }
    return aCondition;
  });
  return value;
}

Future<void> createReturnOrder(
    int distributorID, List returnOrdersCountList, context) async {
  int _SOID = meSO!.SOID;
  String _remarks = "Success";
  DistributorReturnOrderService distributorReturnOrderService =
      DistributorReturnOrderService();
  distributorReturnOrderService
      .insertDistributorReturnOrder(distributorID, _SOID, true, false, _remarks)
      .then((value) async {
    int distributorReturnOrderID = value;
    returnOrdersCountList.forEach(
      (element) async {
        int secondaryAlternativeItemCount = 0;
        DistributorReturnOrderItemService distributorReturnOrderItemService =
            DistributorReturnOrderItemService();
        distributorReturnOrderItemService.insertDistributorReturnOrderItem(
            distributorReturnOrderID,
            element[0].SKUID,
            element[1],
            element[2],
            secondaryAlternativeItemCount,
            element[3]);
      }, //physical damage, near about expiry dateTime
    );
  });
}
