import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUStock.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SKUStockService.dart';

import '../../Database.dart';
import '../../Header.dart';

class SingularStockScreen extends StatelessWidget {
  final Distributor distributor;
  final List<SKUStock> myDistributorStocks;

  SingularStockScreen(this.distributor, this.myDistributorStocks);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Header(15, false, () {}),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 2),
                            blurRadius: 3),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: allSubGroupsLocal
                              .where((element) =>
                                  allSKULocal
                                      .where((e) =>
                                          element.subGroupID == e.subGroupID)
                                      .length !=
                                  0)
                              .map((e) {
                            List<SKU> mySubGroupSKUs = allSKULocal
                                .where((element) =>
                                    element.subGroupID == e.subGroupID)
                                .toList();
                            if (mySubGroupSKUs.length == 0) {
                              return Container();
                            } else {
                              return Container(
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
                                      padding: const EdgeInsets.only(
                                        right: 12,
                                        left: 12,
                                      ),
                                      child: Row(
                                        children: [
                                          Builder(builder: (context) {
                                            return Text(
                                              e.subGroupName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: mySubGroupSKUs.map((f) {
                                        SKUStock skuStock;
                                        try {
                                          skuStock = myDistributorStocks
                                              .firstWhere((element) =>
                                                  element.SKUID == f.SKUID &&
                                                  element.distributorID ==
                                                      distributor
                                                          .distributorID);
                                        } catch (e) {
                                          skuStock = SKUStock(
                                              0,
                                              f.SKUID,
                                              distributor.distributorID,
                                              meSOID!,
                                              true);
                                        }

                                        return skuStock.primaryStock != 0 ||
                                                skuStock.alternativeStock != 0
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        child: Text(
                                                          f.SKUName,
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Center(
                                                              child: skuStock
                                                                          .primaryStock !=
                                                                      0
                                                                  ? Text(
                                                                      skuStock.primaryStock
                                                                              .toString() +
                                                                          allUnitsLocal
                                                                              .firstWhere((z) => z.unitID == f.primaryUnitID)
                                                                              .unitName,
                                                                    )
                                                                  : Container(),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Center(
                                                              child: skuStock
                                                                          .primaryStock !=
                                                                      0
                                                                  ? Text(
                                                                      skuStock.alternativeStock
                                                                              .toString() +
                                                                          allUnitsLocal
                                                                              .firstWhere((z) => z.unitID == f.alternativeUnitID)
                                                                              .unitName,
                                                                    )
                                                                  : Container(),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container();
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
