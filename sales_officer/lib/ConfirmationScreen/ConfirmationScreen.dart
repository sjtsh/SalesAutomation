import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BreadCrum/BreadCrum.dart';
import 'package:sales_officer/ConfirmationScreen/ConfirmationReciept.dart';
import 'package:sales_officer/DialogBox/DialogBox.dart';
import 'package:sales_officer/Header.dart';
import 'package:sales_officer/DistributorList/NewOrder.dart';

class ConfirmationScreen extends StatelessWidget {
  final Distributor currentDistributor;
  final List<TextEditingController> _textEditingControllers;
  final List receiptData;

  ConfirmationScreen(
      this.currentDistributor, this._textEditingControllers, this.receiptData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header(2, false),
          Container(
              padding: EdgeInsets.only(left: 12),
              alignment: Alignment.centerLeft,
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.black.withOpacity(0.1),
                  ),
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: BreadCrum3(
                  "Distributor", currentDistributor.distributorName)),
          Expanded(
            child: ConfirmationReciept(
              currentDistributor,
              _textEditingControllers,
              receiptData,
            ),
          ),
        ],
      ),
    );
  }
}
