import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorSale.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderItemService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/NepaliDateService.dart';

import '../../Database.dart';

calculateSales(context) {
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
        personalDistributorsLocal.forEach((aDistributor) {
          double mtd = 0;
          double ytd = 0;
          distributorOrder
              .where((aDistributorOrder) =>
                  aDistributorOrder.SOID == meSOID &&
                  aDistributorOrder.distributorID ==
                      aDistributor.distributorID &&
                  aDistributorOrder.orderStatus)
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
                      } catch (e) {}
                      if (sku.MRP != -2000.0) {
                        double balance = sku.MRP *
                                aDistributorOrderItem.primaryItemCount *
                                sku.primaryCF +
                            sku.MRP *
                                aDistributorOrderItem.alternativeItemCount *
                                sku.alternativeCF;

                        mtd += balance;

                        if (products.containsKey(sku.SKUID)) {
                          products[sku.SKUID][0] += balance;
                        } else {
                          products.addAll({
                            sku.SKUID: [balance, 0]
                          });
                        }
                      }
                    });
                  }
                } else if (int.parse(
                        aDistributorOrder.dateAndTime.substring(5, 7)) ==
                    int.parse(time.substring(5, 7)) - 1) {
                  if (int.parse(
                          aDistributorOrder.dateAndTime.substring(8, 10)) >
                      int.parse(time.substring(8, 10))) {
                    distributorOrderItem
                        .where((element) =>
                            element.distributorOrderID ==
                            aDistributorOrder.distributorOrderID)
                        .forEach((aDistributorOrderItem) {
                      SKU sku = SKU(
                        aDistributorOrderItem.SKUID,
                        1,
                        1,
                        1,
                        1,
                        0,
                        0,
                        0,
                        0,
                        0,
                        "",
                        -2000,
                        true,
                        SKUERPID: "",
                        img: "",
                      );

                      try {
                        sku = allSKULocal.firstWhere(
                            (e) => e.SKUID == aDistributorOrderItem.SKUID);
                      } catch (e) {}
                      double balance = 0;
                      if (sku.MRP != -2000.0) {
                        balance = sku.MRP *
                                aDistributorOrderItem.primaryItemCount *
                                sku.primaryCF +
                            sku.MRP *
                                aDistributorOrderItem.alternativeItemCount *
                                sku.alternativeCF;

                        mtd += balance;
                      }
                      if (products.containsKey(sku.SKUID)) {
                        products[sku.SKUID][0] += balance;
                      } else {
                        products.addAll({
                          sku.SKUID: [balance, 0]
                        });
                      }
                    });
                  }
                }
              }
            }

            //FOR YTD
            if (aDistributorOrder.dateAndTime != "null") {
              if (aDistributorOrder.dateAndTime.substring(0, 4) ==
                  time.substring(0, 4)) {
                if (int.parse(aDistributorOrder.dateAndTime.substring(5, 7)) <=
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
                      true,
                      SKUERPID: "",
                      img: "",
                    );

                    try {
                      sku = allSKULocal.firstWhere(
                          (e) => e.SKUID == aDistributorOrderItem.SKUID);
                    } catch (e) {}
                    double balance = 0;
                    if (sku.MRP != -2000.0) {
                      balance = sku.MRP *
                              aDistributorOrderItem.primaryItemCount *
                              sku.primaryCF +
                          sku.MRP *
                              aDistributorOrderItem.alternativeItemCount *
                              sku.alternativeCF;

                      ytd += balance;
                    }

                    if (products.containsKey(sku.SKUID)) {
                      products[sku.SKUID][1] += balance;
                    } else {
                      products.addAll({
                        sku.SKUID: [0, balance]
                      });
                    }
                  });
                }
              } else if (int.parse(
                      aDistributorOrder.dateAndTime.substring(0, 4)) ==
                  int.parse(time.substring(0, 4)) - 1) {
                if (int.parse(aDistributorOrder.dateAndTime.substring(5, 7)) >
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
                      true,
                      SKUERPID: "",
                      img: "",
                    );

                    try {
                      sku = allSKULocal.firstWhere(
                          (e) => e.SKUID == aDistributorOrderItem.SKUID);
                    } catch (e) {}
                    double balance = 0;
                    if (sku.MRP != -2000.0) {
                      balance = sku.MRP *
                              aDistributorOrderItem.primaryItemCount *
                              sku.primaryCF +
                          sku.MRP *
                              aDistributorOrderItem.alternativeItemCount *
                              sku.alternativeCF;
                    }
                    if (products.containsKey(sku.SKUID)) {
                      products[sku.SKUID][1] += balance;
                    } else {
                      products.addAll({
                        sku.SKUID: [0, balance]
                      });
                    }
                  });
                }
              }
            }
          });
          String lastOrder = "None";
          List<DistributorOrder> distributorOrders = distributorOrder
              .where((aDistributorOrder) =>
                  aDistributorOrder.SOID == meSOID &&
                  aDistributorOrder.distributorID ==
                      aDistributor.distributorID &&
                  aDistributorOrder.orderStatus)
              .toList();
          if (distributorOrders.length != 0) {
            lastOrder = distributorOrder
                .where((aDistributorOrder) =>
                    aDistributorOrder.distributorID ==
                        aDistributor.distributorID &&
                    aDistributorOrder.orderStatus)
                .last
                .dateAndTime;
          }
          allDistributorSalesLocal.add(
            DistributorSale(
              aDistributor,
              mtd,
              ytd,
              5000,
              lastOrder,
            ),
          );
        });
      });
    });
  });
}
