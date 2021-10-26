import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUDistributorWise.dart';

import '../Database.dart';

class StockReturnModal extends StatefulWidget {
  final SKU sku;
  final TextEditingController primaryStockController;
  final TextEditingController alternativeStockController;
  final SKUDistributorWise skuDistributorWise;
  final List returnOrdersCountList;
  final Function updateReturnOrdersCountList;
  final Function refresh;

  StockReturnModal(
    this.sku,
    this.primaryStockController,
    this.alternativeStockController,
    this.skuDistributorWise,
    this.returnOrdersCountList,
    this.updateReturnOrdersCountList,
    this.refresh,
  );

  @override
  State<StockReturnModal> createState() => _StockReturnModalState();
}

class _StockReturnModalState extends State<StockReturnModal> {
  final TextEditingController _textEditingControllerPrimary =
      TextEditingController();

  final TextEditingController _textEditingControllerAlternative =
      TextEditingController();

  String _value = "damaged";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
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
                height: 450,
                clipBehavior: Clip.hardEdge,
                width: MediaQuery.of(context).size.width - 100,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Return Stock",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                personalDistributorsLocal
                                    .firstWhere((element) =>
                                        element.distributorID ==
                                        widget.skuDistributorWise.distributorID)
                                    .distributorName,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Material(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                height: 40,
                                width: 50,
                                child: Center(
                                  child: Icon(Icons.cancel),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black.withOpacity(0.1),
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Return Stock: "),
                          SizedBox(
                            height: 6,
                          ),
                          Text(widget.sku.SKUName),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xffF5F5F5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      "Stock Present: ${widget.primaryStockController.text}${allUnitsLocal.firstWhere((element) => widget.skuDistributorWise.primaryUnitID == element.unitID).unitName} ${widget.alternativeStockController.text}${allUnitsLocal.firstWhere((element) => widget.skuDistributorWise.alternativeUnitID == element.unitID).unitName}",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.green),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(child: Container()),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Colors.blue.withOpacity(0.1)),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: TextField(
                                      controller: _textEditingControllerPrimary,
                                      cursorWidth: 1,
                                      keyboardType: TextInputType.number,
                                      cursorColor: Colors.blue,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                        hintText: "0",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.blue.withOpacity(0.1)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: TextField(
                                      controller:
                                          _textEditingControllerAlternative,
                                      cursorWidth: 1,
                                      keyboardType: TextInputType.number,
                                      cursorColor: Colors.blue,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.left,
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
                          SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black.withOpacity(0.1),
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Reason:",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Material(
                                    color: _value == "expiry"
                                        ? Colors.blue
                                        : Color(0xffF5F5F5),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _value = "expiry";
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        child: Center(
                                            child: Text(
                                          "Expiry Issue",
                                          style: TextStyle(
                                              color: _value == "expiry"
                                                  ? Colors.white
                                                  : Colors.black),
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Material(
                                    color: _value == "damaged"
                                        ? Colors.blue
                                        : Color(0xffF5F5F5),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _value = "damaged";
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        child: Center(
                                            child: Text(
                                          "Physical Damage",
                                          style: TextStyle(
                                              color: _value == "damaged"
                                                  ? Colors.white
                                                  : Colors.black),
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xffF5F5F5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text("Select Expiry Date"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, bottom: 12.0),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            int actualPrimaryCountNew = widget
                                        .primaryStockController.text ==
                                    ""
                                ? 0
                                : int.parse(widget.primaryStockController.text);
                            int actualAlternativeCountNew =
                                widget.alternativeStockController.text == ""
                                    ? 0
                                    : int.parse(
                                        widget.alternativeStockController.text);
                            int primaryCountNew = _textEditingControllerPrimary
                                        .text ==
                                    ""
                                ? 0
                                : int.parse(_textEditingControllerPrimary.text);
                            int alternativeCountNew =
                                _textEditingControllerAlternative.text == ""
                                    ? 0
                                    : int.parse(
                                        _textEditingControllerAlternative.text);
                            if (primaryCountNew > actualPrimaryCountNew ||
                                alternativeCountNew >
                                    actualAlternativeCountNew) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Not enough stock")));
                            } else {
                              widget.updateReturnOrdersCountList(widget.sku,
                                  primaryCountNew, alternativeCountNew, _value);
                            }
                            Navigator.pop(context);
                            widget.refresh();
                            print("______________________________________");
                            print("primary stock has now the value of: " +
                                widget.primaryStockController.text);
                            print("primary stock has now the value of: " +
                                widget.alternativeStockController.text);

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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
