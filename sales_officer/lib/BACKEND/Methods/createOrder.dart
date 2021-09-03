import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrderItem.dart';
import 'package:sales_officer/BACKEND/Entities/SKUStock.dart';
import 'package:sales_officer/BACKEND/Services/DistributorOrderItemService.dart';
import 'package:sales_officer/BACKEND/Services/DistributorOrderService.dart';
import 'package:sales_officer/BACKEND/Services/SKUStockService.dart';

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

Future<bool> updateOrder(
  DistributorOrder distributorOrder,
  List<DistributorOrderItem> distributorOrderItems,
  List<TextEditingController> _textEditingControllers,
  context,
) async {
  bool conditionOnly = true;
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
          distributorOrderItemService
              .updateDistributorOrderItem(DistributorOrderItem(
                  distributorOrderItem.distributorOrderItemID,
                  distributorOrderItem.distributorOrderID,
                  distributorOrderItem.SKUID,
                  myPrimaryCount,
                  myAlternativeCount,
                  0))
              .then((value) {
            if (!value) {
              conditionOnly = false;
            }
          });
        }
      });

      if (!isToBeUpdated) {
        if (myPrimaryCount != 0 || myAlternativeCount != 0) {
          DistributorOrderItemService distributorOrderItemService =
              DistributorOrderItemService();
          distributorOrderItemService
              .insertDistributorOrderItem(
                  distributorOrder.distributorOrderID,
                  allSKULocal[_textEditingControllers
                              .indexOf(textEditingController) ~/
                          2]
                      .SKUID,
                  myPrimaryCount,
                  myAlternativeCount,
                  0)
              .then((value) {
            if (!value) {
              conditionOnly = false;
            }
          });
        }
      }
    }
  });
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
}

Future<bool> updateStock(int distributorID,
    List<TextEditingController> _textEditingControllers, context) async {
  bool conditionOnly = true;
  _textEditingControllers.forEach((textEditingController) {
    if (_textEditingControllers.indexOf(textEditingController) % 2 == 0) {
      int myPrimaryCount = 0;
      int myAlternativeCount = 0;

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
      SKUStock mySKUStock = allSKUStocksLocal!.firstWhere((element) =>
      element.distributorID == distributorID &&
          allSKULocal[_textEditingControllers
              .indexOf(textEditingController) ~/
              2]
              .SKUID ==
              element.SKUID);
      SKUStockService skuStockService = SKUStockService();
      Geolocator.getCurrentPosition().then((value) => skuStockService
              .updateSKUStock(SKUStock(
                  mySKUStock.SKUStockID,
                  mySKUStock.SKUID,
                  mySKUStock.distributorID,
                  myPrimaryCount,
                  myAlternativeCount,
                  0,
                  DateTime.now().toString(),
                  value.latitude,
                  value.longitude))
              .then((value) {
            if (!value) {
              conditionOnly = false;
            }
          }));
    }
  });
  if (conditionOnly) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Stock was successfully updated")));
    print(conditionOnly);
    return true;
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Stock was not updated")));
    return false;
  }
  return true;
}
