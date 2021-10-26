import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrderItem.dart';
import 'package:sales_officer/ConfirmationScreen/ConfirmationScreen.dart';
import 'package:sales_officer/Database.dart';

class ConfirmOrder extends StatefulWidget {
  final Distributor currentDistributor;
  final List<TextEditingController> _textEditingControllers;
  final int index;
  final bool isNew;
  final DistributorOrder distributorOrder;
  final List<DistributorOrderItem> distributorOrderItems;

  ConfirmOrder(
    this.currentDistributor,
    this._textEditingControllers,
    this.index,
    this.isNew,
    this.distributorOrder,
    this.distributorOrderItems,
  );

  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
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
              "REVIEW ORDER",
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
          return ConfirmationScreen(
            widget.currentDistributor,
            widget._textEditingControllers,
            receiptData,
            widget.index,
            widget.isNew,
            widget.distributorOrder,
            widget.distributorOrderItems,
          );
        },
      ),
    );
  }
}
