import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrderItem.dart';
import 'package:sales_officer/Database.dart';

import 'StockConfirmationScreen.dart';

class StockConfirmOrder extends StatefulWidget {
  final Distributor currentDistributor;
  final List<TextEditingController> _textEditingControllers;
  final int index;
  final DistributorOrder distributorOrder;
  final List<DistributorOrderItem> distributorOrderItems;
  final List returnOrdersCountList;
  final Function updateReturnOrdersCountList;
  final Function refresh;

  StockConfirmOrder(
      this.currentDistributor,
      this._textEditingControllers,
      this.index,
      this.distributorOrder,
      this.distributorOrderItems,
      this.returnOrdersCountList,
      this.updateReturnOrdersCountList,
      this.refresh);

  @override
  _StockConfirmOrderState createState() => _StockConfirmOrderState();
}

class _StockConfirmOrderState extends State<StockConfirmOrder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: MaterialButton(
          color: Colors.green,
          onPressed: () {
            takeToReciept();
          },
          child: Center(
            child: Text(
              "REVIEW STOCK",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  takeToReciept() {
    // widget._textEditingControllers.forEach((element) {
    //   print(element.text);
    // });
    List receiptData = [];
    widget._textEditingControllers.forEach((element) {
      int primaryCount = 0;
      int alternativeCount = 0;
      if (widget._textEditingControllers.indexOf(element) % 2 == 0) {
        if (element.text != "") {
          primaryCount = int.parse(element.text);
        }
        if (widget
                ._textEditingControllers[
                    widget._textEditingControllers.indexOf(element) + 1]
                .text !=
            "") {
          alternativeCount = int.parse(widget
              ._textEditingControllers[
                  widget._textEditingControllers.indexOf(element) + 1]
              .text);
        }
        if (primaryCount != 0 || alternativeCount != 0) {
          receiptData.add([
            allSKULocal[widget._textEditingControllers.indexOf(element) ~/ 2],
            primaryCount,
            alternativeCount
          ]);
        }
      }
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return StockConfirmationScreen(
              widget.currentDistributor,
              widget._textEditingControllers,
              receiptData,
              widget.index,
              widget.distributorOrder,
              widget.distributorOrderItems,
              widget.returnOrdersCountList,
              widget.updateReturnOrdersCountList,
              widget.refresh);
        },
      ),
    );
  }
}
