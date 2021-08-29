import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrderItem.dart';
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

  ConfirmationReciept(
      this.currentDistributor, this._textEditingControllers, this.receiptData);

  @override
  _ConfirmationRecieptState createState() => _ConfirmationRecieptState();
}

class _ConfirmationRecieptState extends State<ConfirmationReciept> {
  double totalAmount = 0;

  Text getTotalItems() {
    num _total = 0;
    widget.receiptData.forEach((element) {
      _total = _total + element[1] + element[2];
    });
    return Text(_total.toString());
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

  deleteReceiptData(f) {
    setState(() {
      widget.receiptData.remove(f);
      widget._textEditingControllers[allSKULocal.indexOf(f[0]) * 2].text = "";
      widget._textEditingControllers[allSKULocal.indexOf(f[0]) * 2 + 1].text =
          "";
    });
  }

  updateReceiptData(List f, int primaryCountNew, int alternativeCountNew) {
    print(primaryCountNew);
    print(alternativeCountNew);
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
      try {
        widget._textEditingControllers[allSKULocal.indexOf(f[0]) * 2].text =
            primaryCountNew.toString();
      } catch (e) {
        print("changing first text editing controller was not successful");
      }
      try {
        widget._textEditingControllers[allSKULocal.indexOf(f[0]) * 2 + 1].text =
            alternativeCountNew.toString();
      } catch (e) {
        print("changing second text editing controller was not successful");
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SKUService skuService = SKUService();
    skuService.fetchSKUs().then((value) {
      allSKULocal = value;
    });
    SKUDistributorWiseService skuDistributorWiseService =
        SKUDistributorWiseService();
    skuDistributorWiseService.fetchSKUDistributorWises().then((value) {
      allSKUDistributorWiseLocal = value;
      widget._textEditingControllers.forEach((aTextEditingController) {
        if (aTextEditingController.text != "" &&
            widget._textEditingControllers.indexOf(aTextEditingController) %
                    2 ==
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
    });
  }

  @override
  Widget build(BuildContext context) {
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
              getTotalItems(),
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
                                    allSubGroupsLocal[e].subGroupName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  Text(getSubGroupItems(e).length.toString()),
                                  Text(
                                    " Pcs",
                                    style: TextStyle(fontSize: 12),
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
                  child: MaterialButton(
                    onPressed: () {
                      createOrder(widget.currentDistributor.distributorID,
                          widget._textEditingControllers, context);
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
}
