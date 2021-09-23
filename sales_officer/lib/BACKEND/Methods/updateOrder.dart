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

Future<bool> updateOrder(
  DistributorOrder distributorOrder,
  List<DistributorOrderItem> distributorOrderItems,
  List<TextEditingController> _textEditingControllers,
  bool isWarning,
) {
  Future<bool> conditionOnly;
  _textEditingControllers.forEach((textEditingController) {
    if (_textEditingControllers.indexOf(textEditingController) % 2 == 0) {
      int myPrimaryCount = 0;
      int myAlternativeCount = 0;
      bool isToBeUpdated = false;
      if (textEditingController.text != "") {
        myPrimaryCount = int.parse(textEditingController.text);
      }
      if (_textEditingControllers[
                  _textEditingControllers.indexOf(textEditingController) + 1]
              .text !=
          "") {
        myAlternativeCount = int.parse(_textEditingControllers[
                _textEditingControllers.indexOf(textEditingController) + 1]
            .text);
      }
      distributorOrderItems.forEach((distributorOrderItem) {
        if (distributorOrderItem.SKUID ==
            allSKULocal[
                    _textEditingControllers.indexOf(textEditingController) ~/ 2]
                .SKUID) {
          isToBeUpdated = true;
          DistributorOrderItemService distributorOrderItemService =
              DistributorOrderItemService();
          conditionOnly = distributorOrderItemService
              .updateDistributorOrderItem(DistributorOrderItem(
                  distributorOrderItem.distributorOrderItemID,
                  distributorOrderItem.distributorOrderID,
                  distributorOrderItem.SKUID,
                  myPrimaryCount,
                  myAlternativeCount,
                  0));
        }
      });

      if (!isToBeUpdated) {
        if (myPrimaryCount != 0 || myAlternativeCount != 0) {
          DistributorOrderItemService distributorOrderItemService =
              DistributorOrderItemService();
          conditionOnly =
              distributorOrderItemService.insertDistributorOrderItem(
                  distributorOrder.distributorOrderID,
                  allSKULocal[_textEditingControllers
                              .indexOf(textEditingController) ~/
                          2]
                      .SKUID,
                  myPrimaryCount,
                  myAlternativeCount,
                  0);
        }
      }
    }
  });
  DistributorOrderService distributorOrderService = DistributorOrderService();
  DistributorOrder newDistributorOrder = DistributorOrder(
      distributorOrder.distributorOrderID,
      distributorOrder.distributorID,
      distributorOrder.SOID,
      distributorOrder.joint,
      !isWarning,
      distributorOrder.remarks,
      distributorOrder.dateAndTime,
      DateTime.now().toString(),
      distributorOrder.lat,
      distributorOrder.lng);
  conditionOnly =
      distributorOrderService.updateDistributorOrder(newDistributorOrder);
  return conditionOnly;
}
