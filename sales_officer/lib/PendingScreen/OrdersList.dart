import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrder.dart';

import 'SingularPending.dart';

class OrdersList extends StatelessWidget {
  final List<DistributorOrder> distributorOrders;
  final bool condition;

  OrdersList(this.distributorOrders, this.condition);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
      ),
      child: ListView(
        children: [
          SizedBox(height: 7),
          Column(
            children: distributorOrders
                .where((element) => condition ? element.orderStatus: !element.orderStatus)
                .map(
                  (e) => SingularPending(e),
            )
                .toList(),
          ),
          SizedBox(height: 7),
        ],
      ),
    );
  }
}
