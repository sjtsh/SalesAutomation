import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrderItem.dart';
import 'package:sales_officer/BACKEND/Entities/SubGroup.dart';
import 'package:sales_officer/ConfirmationScreen/ConfirmationScreen.dart';
import 'package:sales_officer/Database.dart';

class ConfirmOrder extends StatefulWidget {
  final Distributor currentDistributor;
  final List<TextEditingController> _textEditingControllers;
  final int index;

  ConfirmOrder(this.currentDistributor, this._textEditingControllers, this.index);

  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        List receiptData = [];
        widget._textEditingControllers.forEach(
          (element) {
            if (element.text != "") {
              receiptData.add([
                allSKULocal[widget._textEditingControllers.indexOf(element)],
                int.parse(element.text),
              ]);
            }
          },
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return ConfirmationScreen(
                widget.currentDistributor,
                widget._textEditingControllers,
                receiptData,
                widget.index,
              );
            },
          ),
        );
      },
      child: Container(
        height: 40,
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Next",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
