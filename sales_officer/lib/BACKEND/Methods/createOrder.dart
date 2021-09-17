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

Future<bool> createOrder(
    int distributorID,
    List<TextEditingController> _textEditingControllers,
    bool isWarning,
    context) async {
  bool conditionOnly = true;
  await Future(() {
    int _distributorID = distributorID;
    int _SOID = meSO!.SOID;
    bool _joint = true;
    bool _orderStatus = !isWarning;
    String _remarks = "Success";
    String _dateAndTime = DateTime.now().toString();
    DistributorOrderService distributorOrderService = DistributorOrderService();
    distributorOrderService
        .insertDistributorOrder(
            _distributorID, _SOID, _joint, _orderStatus, _remarks, _dateAndTime)
        .then((value) async {
      if (value < 0) {
        conditionOnly = false;
      }
      int distributorOrderID = value;
      try {
        _textEditingControllers.forEach(
          (element) async {
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
                distributorOrderItemService
                    .insertDistributorOrderItem(
                        distributorOrderID,
                        SKUID,
                        primaryItemCount,
                        alternativeItemCount,
                        secondaryAlternativeItemCount)
                    .then((value) {
                  if (!value) {
                    conditionOnly = false;
                  }
                });
              }
            }
          },
        );
      } catch (e) {
        conditionOnly = false;
      }
    });
    return conditionOnly;
  }).then((value) {
    if (value) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Order was successfully punched")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Order was not successful")));
    }
  }).catchError((_) {
    conditionOnly = false;
  });
  return conditionOnly;
}

Future<bool> updateOrder(
  DistributorOrder distributorOrder,
  List<DistributorOrderItem> distributorOrderItems,
  List<TextEditingController> _textEditingControllers,
  bool isWarning,
  context,
) async {
  bool conditionOnly = true;
  await Future(() {
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
                      _textEditingControllers.indexOf(textEditingController) ~/
                          2]
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
    distributorOrderService.updateDistributorOrder(newDistributorOrder);
  }).then((value) {
    if (conditionOnly) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Order was successfully punched")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Order was not successful")));
    }
  }).catchError((_) {
    conditionOnly = false;
  });
  return conditionOnly;
}

Future<bool> updateStock(int distributorID,
    List<TextEditingController> _textEditingControllers, context) async {
  bool conditionOnly = true;
  Future(() {
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
  }).then((value) {
    if (conditionOnly) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Stock was successfully updated")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Stock was not updated")));
    }
  }).catchError((_) {
    conditionOnly = false;
  });
  return conditionOnly;
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
