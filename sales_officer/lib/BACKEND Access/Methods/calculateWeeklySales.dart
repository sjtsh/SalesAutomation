import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderItemService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/NepaliDateService.dart';

import '../../Database.dart';

calculateWeeklySales(context) async {
  weeklySalesLocal = List.generate(4, (index) => 0);
  monthlySalesLocal = List.generate(12, (index) => 0);
  NepaliDateService nepaliDateService = NepaliDateService();
  await nepaliDateService.fetchNepaliDate().then((time) {
    DistributorOrderService distributorOrderService = DistributorOrderService();
    distributorOrderService
        .fetchDistributorOrders(context)
        .then((distributorOrder) async {
      DistributorOrderItemService distributorOrderItemService =
          DistributorOrderItemService();
      await distributorOrderItemService
          .fetchDistributorOrderItems(context)
          .then((distributorOrderItem) {
        distributorOrder
            .where((aDistributorOrder) =>
                aDistributorOrder.orderStatus &&
                !aDistributorOrder.deactivated &&
                aDistributorOrder.SOID == meSOID)
            .forEach((aDistributorOrder) {
          //FOR MTD
          if (aDistributorOrder.dateAndTime != "null") {
            if (aDistributorOrder.dateAndTime.substring(0, 4) ==
                time.substring(0, 4)) {
              if (aDistributorOrder.dateAndTime.substring(5, 7) ==
                  time.substring(5, 7)) {
                if (int.parse(aDistributorOrder.dateAndTime.substring(8, 10)) <=
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
                        SKU sku = SKU(
                          1,
                          1,
                          1,
                          1,
                          1,
                          1,
                          1,
                          1,
                          1,
                          1,
                          "",
                          -2000,
                          false,
                          SKUERPID: "",
                          img: "",
                        );
                        try {
                          sku = allSKULocal.firstWhere(
                              (e) => e.SKUID == aDistributorOrderItem.SKUID);
                        } catch (e) {
                          print("no sku found");
                        }
                        if (sku.MRP != -2000) {
                          weeklySalesLocal[3 - n] += sku.MRP *
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
                      aDistributorOrder.dateAndTime.substring(5, 7)) ==
                  int.parse(time.substring(5, 7)) - 1) {
                if (int.parse(aDistributorOrder.dateAndTime.substring(8, 10)) >
                    nepaliBreaks[int.parse(
                            aDistributorOrder.dateAndTime.substring(0, 4)) -
                        2076][int.parse(
                            aDistributorOrder.dateAndTime.substring(5, 7)) -
                        2]) {

                  for (int n = 0; n < 4; n++) {
                    if (int.parse(aDistributorOrder.dateAndTime
                                .substring(8, 10)) +
                            7 * (n) >
                        int.parse(time.substring(8, 10)) + 30) {
                      distributorOrderItem
                          .where((element) =>
                              element.distributorOrderID ==
                              aDistributorOrder.distributorOrderID)
                          .forEach((aDistributorOrderItem) {
                        SKU sku = SKU(
                          1,
                          1,
                          1,
                          1,
                          1,
                          1,
                          1,
                          1,
                          1,
                          1,
                          "",
                          -2000,
                          false,
                          SKUERPID: "",
                          img: "",
                        );
                        try {
                          sku = allSKULocal.firstWhere(
                              (e) => e.SKUID == aDistributorOrderItem.SKUID);
                        } catch (e) {
                          print("no sku found");
                        }
                        if (sku.MRP != -2000) {
                          weeklySalesLocal[3-n] += sku.MRP *
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
                  if (int.parse(aDistributorOrder.dateAndTime.substring(5, 7)) +
                          n ==
                      int.parse(time.substring(5, 7))) {
                    distributorOrderItem
                        .where((element) =>
                            element.distributorOrderID ==
                            aDistributorOrder.distributorOrderID)
                        .forEach((aDistributorOrderItem) {
                      SKU sku = SKU(
                        1,
                        1,
                        1,
                        1,
                        1,
                        1,
                        1,
                        1,
                        1,
                        1,
                        "",
                        -2000,
                        false,
                        SKUERPID: "",
                        img: "",
                      );

                      try {
                        sku = allSKULocal.firstWhere(
                            (e) => e.SKUID == aDistributorOrderItem.SKUID);
                      } catch (e) {
                        print("no sku found");
                      }
                      if (sku.MRP != -2000) {
                        monthlySalesLocal[11 - n] += sku.MRP *
                                aDistributorOrderItem.primaryItemCount *
                                sku.primaryCF +
                            sku.MRP *
                                aDistributorOrderItem.alternativeItemCount *
                                sku.alternativeCF;
                      }
                    });
                  }
                }
              }
            }
          } else if (int.parse(aDistributorOrder.dateAndTime.substring(0, 4)) ==
              int.parse(time.substring(0, 4)) - 1) {
            if (int.parse(aDistributorOrder.dateAndTime.substring(5, 7)) >
                int.parse(time.substring(5, 7))) {
              for (int n = 0; n < 12; n++) {
                if (int.parse(aDistributorOrder.dateAndTime.substring(5, 7)) +
                        n >
                    int.parse(time.substring(5, 7)) + 12) {
                  distributorOrderItem
                      .where((element) =>
                          element.distributorOrderID ==
                          aDistributorOrder.distributorOrderID)
                      .forEach((aDistributorOrderItem) {
                    SKU sku = SKU(
                      1,
                      1,
                      1,
                      1,
                      1,
                      1,
                      1,
                      1,
                      1,
                      1,
                      "",
                      -2000,
                      false,
                      SKUERPID: "",
                      img: "",
                    );

                    try {
                      sku = allSKULocal.firstWhere(
                          (e) => e.SKUID == aDistributorOrderItem.SKUID);
                    } catch (e) {
                      print("no sku found");
                    }
                    if (sku.MRP != -2000) {
                      monthlySalesLocal[n] += sku.MRP *
                              aDistributorOrderItem.primaryItemCount *
                              sku.primaryCF +
                          sku.MRP *
                              aDistributorOrderItem.alternativeItemCount *
                              sku.alternativeCF;
                    }
                  });
                }
              }
            }
          }
        });
        print(weeklySalesLocal);
        print(monthlySalesLocal);
      });
    });
  });
}
