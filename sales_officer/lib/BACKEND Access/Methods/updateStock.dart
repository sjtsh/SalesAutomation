import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUStock.dart';
import 'package:sales_officer/BACKEND%20Access/Services/NepaliDateService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SKUStockService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SKUStockTrackService.dart';
import 'package:sales_officer/NavBar/NavBar.dart';
import 'package:sales_officer/StocksScreen/StocksScreen.dart';

import '../../Database.dart';

Future<bool> updateStock(List recieptData, int distributorID,
    List<TextEditingController> _textEditingControllers) {
  Future<bool> conditionOnly = Future<bool>.value(false);
  bool isInserted = true;
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
      SKUStock mySKUStock = SKUStock(
        1,
        allSKULocal[_textEditingControllers.indexOf(textEditingController) ~/ 2]
            .SKUID,
        distributorID,
        meSOID!,
        false,
      );
      try {
        mySKUStock = allSKUStocksLocal.firstWhere((element) =>
            element.distributorID == distributorID &&
            allSKULocal[_textEditingControllers
                            .indexOf(textEditingController) ~/
                        2]
                    .SKUID ==
                element.SKUID);
      } catch (e) {
        print("No sku stock ");
      }

      SKUStockService skuStockService = SKUStockService();
      bool isContains = false;
      ourSKUStock.forEach((element) {
        if (element.SKUID == mySKUStock.SKUID &&
            element.primaryStock == myPrimaryCount &&
            element.alternativeStock == myAlternativeCount) {
          isContains = true;
        }
      });
      if (!isContains) {
        NepaliDateService nepaliDateService = NepaliDateService();
        conditionOnly = nepaliDateService.fetchNepaliDate().then((time) {
          conditionOnly = Geolocator.getCurrentPosition().then(
            (value) => skuStockService
                .updateSKUStock(SKUStock(
              mySKUStock.SKUStockID,
              mySKUStock.SKUID,
              mySKUStock.distributorID,
              mySKUStock.SOID,
              false,
              primaryStock: myPrimaryCount,
              alternativeStock: myAlternativeCount,
              secondaryAlternativeStock: 0,
              updatedDate: time,
              lat: value.latitude,
              lng: value.longitude,
            ))
                .then((value) {
              if (value) {
                if (isInserted) {
                  SKUStockTrackService()
                      .insertSKUStockTrack(meSOID!, distributorID, time);
                  isInserted = false;
                }
              }
              return value;
            }),
          );
          return conditionOnly;
        });
      }
    }
  });
  return conditionOnly;
}
