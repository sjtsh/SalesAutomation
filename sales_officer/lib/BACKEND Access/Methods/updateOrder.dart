import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrderItem.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderItemService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/NepaliDateService.dart';
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
          conditionOnly =
              distributorOrderItemService.updateDistributorOrderItem(
            DistributorOrderItem(
                distributorOrderItem.distributorOrderItemID,
                distributorOrderItem.distributorOrderID,
                distributorOrderItem.SKUID,
                myPrimaryCount,
                myAlternativeCount,
                0,
                false),
          );
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
  NepaliDateService nepaliDateService = NepaliDateService();

  conditionOnly = nepaliDateService.fetchNepaliDate().then((time) {
    return distributorOrderService.updateDistributorOrder(DistributorOrder(
        distributorOrder.distributorOrderID,
        distributorOrder.distributorID,
        distributorOrder.SOID,
        distributorOrder.joint,
        !isWarning,
        distributorOrder.remarks,
        distributorOrder.dateAndTime,
        time,
        distributorOrder.lat,
        distributorOrder.lng,
        false));
  });

  return conditionOnly;
}
