import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';

import 'SingularPending.dart';

class OrdersList extends StatelessWidget {
  final List<DistributorOrder> distributorOrders;
  final int condition;
  final Function refresh;
  final int page;

  OrdersList(this.distributorOrders, this.page, this.refresh, this.condition);

  @override
  Widget build(BuildContext context) {
    List personalDistributorOrders = [];
    distributorOrders.reversed
        .where(
            (element) =>
        condition == 0 ? element.orderStatus : condition == 1
            ? !element.orderStatus
            : false)
        .forEach((element) {
      personalDistributorOrders.add(element);
    });
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
      ),
      child: personalDistributorOrders.length != 0
          ? ListView(
        children: [
          SizedBox(height: 7),
          Column(
            children: personalDistributorOrders
                .map(
                  (e) => SingularPending(e, refresh),
            )
                .toList(),
          ),
          SizedBox(height: 7),
        ],
      )
          : Center(
        child: condition == 0
            ? Text(
          "NO PENDING ORDERS",
          style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 20),
        )
            : condition == 1
            ? Text(
          "NO APPROVED ORDERS",
          style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 20),
        ) :Text(
          "NO DISPATCHED ORDERS",
          style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 20),
        ),
      ),
    );
  }
}
