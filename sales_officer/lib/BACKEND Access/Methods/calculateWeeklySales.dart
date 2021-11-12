import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderItemService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/NepaliDateService.dart';

import '../../Database.dart';

calculateWeeklySales(context) {
  weeklySalesLocal = List.generate(4, (index) => 0);
  monthlySalesLocal = List.generate(12, (index) => 0);
  NepaliDateService nepaliDateService = NepaliDateService();
  nepaliDateService.fetchNepaliDate().then((time) {
    DistributorOrderService distributorOrderService = DistributorOrderService();
    distributorOrderService
        .fetchDistributorOrders(context)
        .then((distributorOrder) {
      DistributorOrderItemService distributorOrderItemService =
          DistributorOrderItemService();
      distributorOrderItemService
          .fetchDistributorOrderItems(context)
          .then((distributorOrderItem) {
        distributorOrderItem.forEach((aDistributorOrderItem) {
          distributorOrder
              .where((aDistributorOrder) => aDistributorOrder.orderStatus && aDistributorOrder.SOID == meSOID)
              .forEach((aDistributorOrder) {
            //FOR MTD
            if (aDistributorOrder.dateAndTime != "null") {
              if (aDistributorOrder.dateAndTime.substring(0, 4) ==
                  time.substring(0, 4)) {
                if (aDistributorOrder.dateAndTime.substring(5, 7) ==
                    time.substring(5, 7)) {
                  if (int.parse(
                          aDistributorOrder.dateAndTime.substring(8, 10)) <=
                      int.parse(time.substring(8, 10))) {
                    for (int n = 0; n < 4; n++) {
                      if (int.parse(aDistributorOrder.dateAndTime
                                  .substring(8, 10)) +
                              7 * (n + 1) >
                          int.parse(time.substring(8, 10))) {
                        distributorOrderItem
                            .where((element) =>
                                element.distributorOrderID ==
                                aDistributorOrder.distributorOrderID)
                            .forEach((aDistributorOrderItem) {
                          SKU sku = SKU(1, "1", 1, 1, 1, 1, 1, 1, 1, 1, 1, "",
                              1, "", false);
                          try {
                            sku = allSKULocal.firstWhere(
                                (e) => e.SKUID == aDistributorOrderItem.SKUID);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "NO SKU FOUND, Please contact IT,",
                              ),
                            ));
                          }
                          if (sku.MRP != "-2000.0") {
                            weeklySalesLocal[n] += sku.MRP *
                                    aDistributorOrderItem.primaryItemCount *
                                    sku.primaryCF +
                                sku.MRP *
                                    aDistributorOrderItem.alternativeItemCount *
                                    sku.alternativeCF;
                          }
                        });
                        break;
                      }
                    }
                  }
                } else if (int.parse(
                            aDistributorOrder.dateAndTime.substring(5, 7)) -
                        1 ==
                    int.parse(time.substring(5, 7))) {
                  if (int.parse(
                          aDistributorOrder.dateAndTime.substring(8, 10)) >
                      int.parse(time.substring(8, 10)) +
                          nepaliBreaks[int.parse(aDistributorOrder.dateAndTime
                                  .substring(0, 4)) -
                              2076][int.parse(aDistributorOrder.dateAndTime
                                  .substring(5, 7)) -
                              1]) {
                    for (int n = 0; n < 4; n++) {
                      if (int.parse(aDistributorOrder.dateAndTime
                                  .substring(8, 10)) +
                              7 * (n + 1) >
                          int.parse(time.substring(8, 10))) {
                        distributorOrderItem
                            .where((element) =>
                                element.distributorOrderID ==
                                aDistributorOrder.distributorOrderID)
                            .forEach((aDistributorOrderItem) {
                          SKU sku = SKU(1, "1", 1, 1, 1, 1, 1, 1, 1, 1, 1, "",
                              1, "", false);
                          try {
                            sku = allSKULocal.firstWhere(
                                (e) => e.SKUID == aDistributorOrderItem.SKUID);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "NO SKU FOUND, Please contact IT,",
                              ),
                            ));
                          }
                          if (sku.MRP != "-2000.0") {
                            weeklySalesLocal[n] += sku.MRP *
                                    aDistributorOrderItem.primaryItemCount *
                                    sku.primaryCF +
                                sku.MRP *
                                    aDistributorOrderItem.alternativeItemCount *
                                    sku.alternativeCF;
                          }
                        });
                        break;
                      }
                    }
                  }
                }
              }
              //FOR YTD
              if (aDistributorOrder.dateAndTime.substring(0, 4) ==
                  time.substring(0, 4)) {
                if (int.parse(aDistributorOrder.dateAndTime.substring(5, 7)) <=
                    int.parse(time.substring(5, 7))) {
                  for (int n = 0; n < 12; n++) {
                    if (int.parse(
                                aDistributorOrder.dateAndTime.substring(5, 7)) +
                            n >
                        int.parse(time.substring(5, 7))) {
                      distributorOrderItem
                          .where((element) =>
                              element.distributorOrderID ==
                              aDistributorOrder.distributorOrderID)
                          .forEach((aDistributorOrderItem) {
                        SKU sku = SKU(1, "1", 1, 1, 1, 1, 1, 1, 1, 1, 1, "", 1,
                            "", false);
                        try {
                          sku = allSKULocal.firstWhere(
                              (e) => e.SKUID == aDistributorOrderItem.SKUID);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("NO SKU FOUND, PLEASE CONTACT IT")));
                        }
                        if (sku.MRP != "-2000.0") {
                          monthlySalesLocal[n] += sku.MRP *
                                  aDistributorOrderItem.primaryItemCount *
                                  sku.primaryCF +
                              sku.MRP *
                                  aDistributorOrderItem.alternativeItemCount *
                                  sku.alternativeCF;
                        }
                      });
                      break;
                    }
                  }
                }
              } else if (int.parse(
                          aDistributorOrder.dateAndTime.substring(0, 4)) -
                      1 ==
                  int.parse(time.substring(0, 4))) {
                if (int.parse(aDistributorOrder.dateAndTime.substring(5, 7)) >
                    int.parse(time.substring(5, 7))) {
                  for (int n = 0; n < 12; n++) {
                    if (int.parse(
                                aDistributorOrder.dateAndTime.substring(5, 7)) +
                            n >
                        int.parse(time.substring(5, 7)) + 12) {
                      distributorOrderItem
                          .where((element) =>
                              element.distributorOrderID ==
                              aDistributorOrder.distributorOrderID)
                          .forEach((aDistributorOrderItem) {
                        SKU sku = SKU(1, "1", 1, 1, 1, 1, 1, 1, 1, 1, 1, "", 1,
                            "", false);
                        try {
                          sku = allSKULocal.firstWhere(
                              (e) => e.SKUID == aDistributorOrderItem.SKUID);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("NO SKU FOUND, PLEASE CONTACT IT")));
                        }
                        if (sku.MRP != "-2000.0") {
                          monthlySalesLocal[n] += sku.MRP *
                                  aDistributorOrderItem.primaryItemCount *
                                  sku.primaryCF +
                              sku.MRP *
                                  aDistributorOrderItem.alternativeItemCount *
                                  sku.alternativeCF;
                        }
                      });
                      break;
                    }
                  }
                }
              }
            }
          });
        });
      });
    });
  });
}
