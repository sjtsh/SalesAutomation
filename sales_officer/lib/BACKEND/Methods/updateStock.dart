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

Future<bool> updateStock(List recieptData, int distributorID,
    List<TextEditingController> _textEditingControllers) {
  Future<bool> conditionOnly = Future<bool>.value(false);
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
          allSKULocal[_textEditingControllers.indexOf(textEditingController) ~/
                      2]
                  .SKUID ==
              element.SKUID);
      SKUStockService skuStockService = SKUStockService();
      bool isContains = false;
      recieptData.forEach((element) {
        if (element[0].SKUID == mySKUStock.SKUID &&
            element[1] == myPrimaryCount &&
            element[2] == myAlternativeCount) {
          isContains = true;
        }
      });
      if (!isContains) {
        conditionOnly = Geolocator.getCurrentPosition().then(
          (value) => skuStockService.updateSKUStock(SKUStock(
              mySKUStock.SKUStockID,
              mySKUStock.SKUID,
              mySKUStock.distributorID,
              myPrimaryCount,
              myAlternativeCount,
              0,
              DateTime.now().toString(),
              value.latitude,
              value.longitude, false)),
        );
      }
    }
  });
  return conditionOnly;
}
