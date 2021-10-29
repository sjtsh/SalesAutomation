import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrderItem.dart';
import 'package:sales_officer/BreadCrum/BreadCrum.dart';
import 'package:sales_officer/ConfirmationScreen/ConfirmationReciept.dart';
import 'package:sales_officer/Header.dart';

class ConfirmationScreen extends StatelessWidget {
  final Distributor currentDistributor;
  final List<TextEditingController> _textEditingControllers;
  final List receiptData;
  final int index;
  final bool isNew;
  final DistributorOrder distributorOrder;
  final List<DistributorOrderItem> distributorOrderItems;
  final Function refresh;

  ConfirmationScreen(
      this.currentDistributor,
      this._textEditingControllers,
      this.receiptData,
      this.index,
      this.isNew,
      this.distributorOrder,
      this.distributorOrderItems, this.refresh);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Header(7, false, refresh),
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
                    "Distributor", currentDistributor.distributorName, "Order Confirmation")),
            Expanded(
              child: ConfirmationReciept(
                  currentDistributor,
                  _textEditingControllers,
                  receiptData,
                  isNew,
                  distributorOrder,
                  distributorOrderItems),
            ),
          ],
        ),
      ),
    );
  }
}
