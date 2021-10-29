import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrderItem.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUDistributorWise.dart';

import '../Database.dart';

class OrderItemsExpanded extends StatelessWidget {
  final List<DistributorOrderItem> distributorOrderItems;
  final List<SKUDistributorWise> skuDistributorWises;

  OrderItemsExpanded(this.distributorOrderItems, this.skuDistributorWises);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpandableButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12),
            child: Row(
              children: [
                Text("Order List"),
                Expanded(
                  child: Container(),
                ),
                Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
        ),
        Column(
          children: distributorOrderItems
              .map(
                (e) => Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF5F5F5),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          allSKULocal
                              .where((element) => element.SKUID == e.SKUID)
                              .first
                              .SKUName,
                          maxLines: 3,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "${e.primaryItemCount}${allUnitsLocal.firstWhere((element) => element.unitID == allSKULocal.firstWhere((element) => e.SKUID == element.SKUID).primaryUnitID).unitName} ${e.alternativeItemCount}${allUnitsLocal.firstWhere((element) => element.unitID == allSKULocal.firstWhere((element) => e.SKUID == element.SKUID).alternativeUnitID).unitName}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
