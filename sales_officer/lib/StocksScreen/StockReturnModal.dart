import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/SKU.dart';
import 'package:sales_officer/BACKEND/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/BACKEND/Entities/SKUStock.dart';
import 'package:sales_officer/BACKEND/Entities/SubGroup.dart';
import 'package:sales_officer/BACKEND/Services/SKUDistributorWiseService.dart';

import '../Database.dart';

class StockReturnModal extends StatelessWidget {
  final SKU sku;
  final TextEditingController primaryStockController;
  final TextEditingController alternativeStockController;
  final SKUDistributorWise skuDistributorWise;
  final List returnOrdersCountList;
  final Function refresh;
  final TextEditingController _textEditingControllerPrimary =
      TextEditingController();
  final TextEditingController _textEditingControllerAlternative =
      TextEditingController();

  StockReturnModal(
    this.sku,
    this.primaryStockController,
    this.alternativeStockController,
    this.skuDistributorWise,
    this.returnOrdersCountList,
    this.refresh,
  );

  @override
  Widget build(BuildContext context) {
    SubGroup subGroup = allSubGroupsLocal
        .firstWhere((element) => element.subGroupID == sku.subGroupID);

    returnOrdersCountList.forEach((element) {
      if (element[0] == sku) {
        if (element[1] != 0) {
          _textEditingControllerPrimary.text = element[1].toString();
        }
        if (element[2] != 0) {
          _textEditingControllerAlternative.text = element[2].toString();
        }
      }
    });

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Center(
              child: Container(
                height: 300,
                clipBehavior: Clip.hardEdge,
                width: MediaQuery.of(context).size.width - 100,
                decoration: ShapeDecoration(
                  color: Color(0xffF5F5F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                subGroup.subGroupName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0, vertical: 1),
                                  child: Text(
                                    subGroup.productLineName.substring(0, 1) +
                                        subGroup.productLineName.substring(
                                            subGroup.productLineName.length - 1,
                                            subGroup.productLineName.length),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Container()),
                          Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.1)),
                            ),
                            padding: const EdgeInsets.only(bottom: 5),
                            child: TextField(
                              controller: _textEditingControllerPrimary,
                              cursorWidth: 1,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.blue,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "0",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.3)),
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Center(
                              child: TextField(
                                controller: _textEditingControllerAlternative,
                                cursorWidth: 1,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.blue,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: "0",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.3)),
                                ),
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      Expanded(child: Container()),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: MaterialButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    bool isConsists = false;
                                    int actualPrimaryCountNew =
                                        primaryStockController.text == ""
                                            ? 0
                                            : int.parse(
                                                primaryStockController.text);
                                    int actualAlternativeCountNew =
                                        alternativeStockController.text == ""
                                            ? 0
                                            : int.parse(
                                                alternativeStockController
                                                    .text);
                                    int primaryCountNew =
                                        _textEditingControllerPrimary.text == ""
                                            ? 0
                                            : int.parse(
                                                _textEditingControllerPrimary
                                                    .text);
                                    int alternativeCountNew =
                                        _textEditingControllerAlternative
                                                    .text ==
                                                ""
                                            ? 0
                                            : int.parse(
                                                _textEditingControllerAlternative
                                                    .text);
                                    if (primaryCountNew >
                                            actualPrimaryCountNew ||
                                        alternativeCountNew >
                                            actualAlternativeCountNew) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text("Not enough stock")));
                                    } else {
                                      returnOrdersCountList.forEach((element) {
                                        if (element[0] == sku) {
                                          isConsists = true;
                                          element[1] = primaryCountNew;
                                          element[2] = alternativeCountNew;
                                        }
                                      });
                                      if (!isConsists) {
                                        returnOrdersCountList.add([
                                          sku,
                                          primaryCountNew,
                                          alternativeCountNew
                                        ]);
                                        refresh();
                                      }
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
