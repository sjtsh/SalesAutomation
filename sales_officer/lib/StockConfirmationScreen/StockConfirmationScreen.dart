import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrderItem.dart';
import 'package:sales_officer/BreadCrum/BreadCrum.dart';
import 'package:sales_officer/Header.dart';

import 'StockConfirmationReciept.dart';

class StockConfirmationScreen extends StatelessWidget {
  final Distributor currentDistributor;
  final List<TextEditingController> _textEditingControllers;
  final List receiptData;
  final int index;
  final DistributorOrder distributorOrder;
  final List<DistributorOrderItem> distributorOrderItems;
  final List returnOrdersCountList;

  StockConfirmationScreen(this.currentDistributor, this._textEditingControllers,
      this.receiptData, this.index, this.distributorOrder, this.distributorOrderItems, this.returnOrdersCountList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header(index, false),
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
            child: StockConfirmationReciept(currentDistributor,
                _textEditingControllers, receiptData, distributorOrder, distributorOrderItems, returnOrdersCountList),
          ),
        ],
      ),
    );
  }
}
