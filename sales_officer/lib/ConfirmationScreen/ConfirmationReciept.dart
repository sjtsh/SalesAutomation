import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrderItem.dart';
import 'package:sales_officer/BACKEND/Entities/SKU.dart';
import 'package:sales_officer/BACKEND/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/BACKEND/Methods/createOrder.dart';
import 'package:sales_officer/BACKEND/Services/DistributorOrderItemService.dart';
import 'package:sales_officer/BACKEND/Services/SKUDistributorWiseService.dart';
import 'package:sales_officer/BACKEND/Services/SKUService.dart';
import 'package:sales_officer/Database.dart';

import 'IndividualConfirmationVariation.dart';

class ConfirmationReciept extends StatefulWidget {
  final Distributor currentDistributor;
  final List<TextEditingController> _textEditingControllers;
  final List receiptData;
  final bool isNew;
  final DistributorOrder distributorOrder;
  final List<DistributorOrderItem> distributorOrderItems;

  ConfirmationReciept(
      this.currentDistributor,
      this._textEditingControllers,
      this.receiptData,
      this.isNew,
      this.distributorOrder,
      this.distributorOrderItems);

  @override
  _ConfirmationRecieptState createState() => _ConfirmationRecieptState();
}

class _ConfirmationRecieptState extends State<ConfirmationReciept> {
  double totalAmount = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    List aList = getTotalItems();
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
                " Ctn",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                width: 10,
              ),
              Text(aList[1].toString()),
              Text(
                " Pcs",
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
                                    (f) => IndividualConfirmationVariation(
                                        updateReceiptData,
                                        f,
                                        deleteReceiptData),
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
                      "Total Value",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      totalAmount.toString(),
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      " Pcs",
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
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : MaterialButton(
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            if (widget.isNew) {
                              createOrder(
                                      widget.currentDistributor.distributorID,
                                      widget._textEditingControllers,
                                      context)
                                  .then((value) => setState(() {
                                        isLoading = false;
                                      }));
                            } else {
                              updateOrder(
                                      widget.distributorOrder,
                                      widget.distributorOrderItems,
                                      widget._textEditingControllers,
                                      context)
                                  .then((value) => setState(() {
                                        isLoading = false;
                                      }));
                            }
                          },
                          child: Center(
                            child: Text(
                              "CONFIRM",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
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
