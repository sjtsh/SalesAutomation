import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/SKU.dart';
import 'package:sales_officer/BACKEND/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/BACKEND/Entities/SKUStock.dart';
import 'package:sales_officer/BACKEND/Entities/SubGroup.dart';
import 'package:sales_officer/BACKEND/Services/SKUDistributorWiseService.dart';

import '../Database.dart';

class StockReturnModal extends StatefulWidget {
  final SKU sku;
  final TextEditingController primaryStockController;
  final TextEditingController alternativeStockController;
  final SKUDistributorWise skuDistributorWise;
  final List returnOrdersCountList;
  final Function refresh;

  StockReturnModal(
    this.sku,
    this.primaryStockController,
    this.alternativeStockController,
    this.skuDistributorWise,
    this.returnOrdersCountList,
    this.refresh,
  );

  @override
  _StockReturnModalState createState() => _StockReturnModalState();
}

class _StockReturnModalState extends State<StockReturnModal> {
  final TextEditingController _textEditingControllerPrimary =
      TextEditingController();

  final TextEditingController _textEditingControllerAlternative =
      TextEditingController();

  String _value = "damaged";

  @override
  Widget build(BuildContext context) {
    SubGroup subGroup = allSubGroupsLocal
        .firstWhere((element) => element.subGroupID == widget.sku.subGroupID);

    widget.returnOrdersCountList.forEach((element) {
      if (element[0] == widget.sku) {
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
          height: 400,
          clipBehavior: Clip.hardEdge,
          width: MediaQuery.of(context).size.width - 100,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  "Return Order",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  color: Colors.black.withOpacity(0.1),
                  thickness: 2,
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(child: Text("Select Reason")),
                    DropdownButton(
                      onChanged: (value) {
                        setState(() {
                          value = _value.toString();
                        });
                      },
                      underline: Container(),
                      value: _value,
                      items: [
                        DropdownMenuItem(
                          child: Text("Near Expiry"),
                          value: "expiry",
                        ),
                        DropdownMenuItem(
                          child: Text("Damaged"),
                          value: "damaged",
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Column(
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
                              fontSize: 12,
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
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        widget.sku.SKUName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
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
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
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
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Row(
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
                                    widget.primaryStockController.text == ""
                                        ? 0
                                        : int.parse(
                                            widget.primaryStockController.text);
                                int actualAlternativeCountNew = widget
                                            .alternativeStockController.text ==
                                        ""
                                    ? 0
                                    : int.parse(
                                        widget.alternativeStockController.text);
                                int primaryCountNew =
                                    _textEditingControllerPrimary.text == ""
                                        ? 0
                                        : int.parse(
                                            _textEditingControllerPrimary.text);
                                int alternativeCountNew =
                                    _textEditingControllerAlternative.text == ""
                                        ? 0
                                        : int.parse(
                                            _textEditingControllerAlternative
                                                .text);
                                if (primaryCountNew > actualPrimaryCountNew ||
                                    alternativeCountNew >
                                        actualAlternativeCountNew) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Not enough stock")));
                                } else {
                                  widget.returnOrdersCountList
                                      .forEach((element) {
                                    if (element[0] == widget.sku) {
                                      isConsists = true;
                                      element[1] = primaryCountNew;
                                      element[2] = alternativeCountNew;
                                      element[3] = _value;
                                    }
                                  });
                                  if (!isConsists) {
                                    widget.returnOrdersCountList.add([
                                      widget.sku,
                                      primaryCountNew,
                                      alternativeCountNew,
                                      _value
                                    ]);
                                    widget.refresh();
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
                ),
                SizedBox(
                  width: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
