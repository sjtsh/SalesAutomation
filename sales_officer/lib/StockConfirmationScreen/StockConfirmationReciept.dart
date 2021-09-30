import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrderItem.dart';
import 'package:sales_officer/BACKEND/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/BACKEND/Methods/createOrder.dart';
import 'package:sales_officer/BACKEND/Methods/updateStock.dart';
import 'package:sales_officer/Database.dart';

import 'StockIndividualConfirmationVariation.dart';

class StockConfirmationReciept extends StatefulWidget {
  final Distributor currentDistributor;
  final List<TextEditingController> _textEditingControllers;
  final List receiptData;
  final DistributorOrder distributorOrder;
  final List<DistributorOrderItem> distributorOrderItems;
  final List returnOrdersCountList;
  final Function updateReturnOrdersCountList;

  StockConfirmationReciept(
      this.currentDistributor,
      this._textEditingControllers,
      this.receiptData,
      this.distributorOrder,
      this.distributorOrderItems,
      this.returnOrdersCountList,
      this.updateReturnOrdersCountList);

  @override
  _StockConfirmationRecieptState createState() =>
      _StockConfirmationRecieptState();
}

class _StockConfirmationRecieptState extends State<StockConfirmationReciept> {
  double totalAmount = 0;
  bool isLoading = false;

  List tempBillingAmounts = [];

  @override
  Widget build(BuildContext context) {
    List aList = getTotalItems();
    if (widget.receiptData.length == 0) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            height: 40,
            child: Row(
              children: [
                Text(
                  "Total Stock",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Text(
                  "0 Units",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Expanded(
              child: Center(
                  child: Text(
            "No Orders",
            style:
                TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 30),
          )))
        ],
      );
    } else {
      return ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            height: 40,
            child: Row(
              children: [
                Text(
                  "Total Stock",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Text(aList[0].toString()),
                Text(
                  " Units",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 2),
                    blurRadius: 3)
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: getSubProducts()
                      .map(
                        (e) => Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black.withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      allSubGroupsLocal
                                          .firstWhere((element) =>
                                              element.subGroupID == e)
                                          .subGroupName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: getSubGroupItems(e)
                                    .map(
                                      (f) =>
                                          StockIndividualConfirmationVariation(
                                              updateReceiptData,
                                              f,
                                              deleteReceiptData,
                                              widget.currentDistributor,
                                              widget.returnOrdersCountList,
                                              widget._textEditingControllers,
                                              widget
                                                  .updateReturnOrdersCountList),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  height: 40,
                  child: Row(
                    children: [
                      Text(
                        "Total Stock Value",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        " Rs.",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        totalAmount.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: isLoading
                        ? MaterialButton(
                            onPressed: () async {},
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : MaterialButton(
                            onPressed: () {
                              if(!isLoading){
                                setState(() {
                                  isLoading = true;
                                });
                                createReturnOrder(
                                    widget.currentDistributor.distributorID,
                                    widget.returnOrdersCountList,
                                    context);
                                updateStock(
                                  widget.receiptData,
                                  widget.currentDistributor.distributorID,
                                  widget._textEditingControllers,
                                ).timeout(Duration(seconds: 30), onTimeout: () {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Please connect to a stronger connection")));
                                  return false;
                                }).then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (value) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Stock was successfully punched")));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Please connect to a stronger connection")));
                                  }
                                });
                              }
                            },
                            child: Center(
                              child: Text(
                                "UPDATE STOCK",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  List getTotalItems() {
    List aList = [0, 0];
    widget.receiptData.forEach((element) {
      aList[0] = aList[0] + element[1];
      aList[1] = aList[1] + element[2];
    });
    return aList;
  }

  List getSubGroupItems(int i) {
    List items = [];
    widget.receiptData.forEach((element) {
      if (element[0].subGroupID == i) {
        items.add(element);
      }
    });
    return items;
  }

  List<int> getSubProducts() {
    List<int> subProducts = [];
    widget.receiptData.forEach((element) {
      if (!subProducts.contains(element[0].subGroupID)) {
        subProducts.add(element[0].subGroupID);
      }
    });
    return subProducts;
  }

  deleteReceiptData(List f) {
    setState(() {
      widget.receiptData.remove(f);
      widget
          ._textEditingControllers[allSKULocal.indexOf(allSKULocal
                  .firstWhere((element) => element.SKUID == f[0].SKUID)) *
              2]
          .text = "";
      widget
          ._textEditingControllers[allSKULocal.indexOf(allSKULocal
                      .firstWhere((element) => element.SKUID == f[0].SKUID)) *
                  2 +
              1]
          .text = "";
      getTotalValue();
    });
  }

  updateReceiptData(List f, int primaryCountNew, int alternativeCountNew) {
    setState(() {
      widget.receiptData.asMap().entries.forEach((element) {
        if (element.value[0] == f[0]) {
          widget.receiptData[element.key] = [
            f[0],
            primaryCountNew,
            alternativeCountNew
          ];
        }
      });
      widget
          ._textEditingControllers[allSKULocal.indexOf(allSKULocal
                  .firstWhere((element) => element.SKUID == f[0].SKUID)) *
              2]
          .text = primaryCountNew.toString();
      widget
          ._textEditingControllers[allSKULocal.indexOf(allSKULocal
                      .firstWhere((element) => element.SKUID == f[0].SKUID)) *
                  2 +
              1]
          .text = alternativeCountNew.toString();
      getTotalValue();
    });
  }

  getTotalValue() {
    totalAmount = 0;
    widget._textEditingControllers.forEach((aTextEditingController) {
      if (aTextEditingController.text != "" &&
          widget._textEditingControllers.indexOf(aTextEditingController) % 2 ==
              0) {
        SKUDistributorWise skuDistributorWise =
            allSKUDistributorWiseLocal.firstWhere((i) =>
                i.SKUID ==
                    allSKULocal[widget._textEditingControllers
                                .indexOf(aTextEditingController) ~/
                            2]
                        .SKUID &&
                i.distributorID == widget.currentDistributor.distributorID);
        setState(() {
          totalAmount += aTextEditingController.text == ""
              ? 0
              : int.parse(aTextEditingController.text) *
                  skuDistributorWise.primaryCF *
                  skuDistributorWise.MRP;

          totalAmount += widget
                      ._textEditingControllers[widget._textEditingControllers
                              .indexOf(aTextEditingController) +
                          1]
                      .text ==
                  ""
              ? 0
              : int.parse(widget
                      ._textEditingControllers[widget._textEditingControllers
                              .indexOf(aTextEditingController) +
                          1]
                      .text) *
                  skuDistributorWise.alternativeCF *
                  skuDistributorWise.MRP;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotalValue();
  }
}
