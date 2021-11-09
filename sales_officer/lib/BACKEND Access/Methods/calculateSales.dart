
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorSale.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderItemService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/NepaliDateService.dart';

import '../../Database.dart';

calculateSales(setLoaded, context) {
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
            if (aDistributorOrder.dateAndTime.substring(0, 4) ==
                time.substring(0, 4)) {
              if (aDistributorOrder.dateAndTime.substring(5, 7) ==
                  time.substring(5, 7)) {
                if (int.parse(aDistributorOrder.dateAndTime.substring(8, 10)) <=
                    int.parse(time.substring(8, 10))) {
                  distributorOrderItem
                      .where((element) =>
                          element.distributorOrderID ==
                          aDistributorOrder.distributorOrderID)
                      .forEach((aDistributorOrderItem) {
                    SKU sku = SKU(1, "", 1, 1, 1, 1, 1, 1, 1, 1, 1, "", 1, "", false);
                    try{
                      SKU sku = allSKULocal.firstWhere(
                          (e) => e.SKUID == aDistributorOrderItem.SKUID);
                    }catch(e){
                      throw Exception("SKU Not Found");
                    }

                    mtd += sku.MRP *
                            aDistributorOrderItem.primaryItemCount *
                            sku.primaryCF +
                        sku.MRP *
                            aDistributorOrderItem.alternativeItemCount *
                            sku.alternativeCF;
                    if (products.containsKey(sku.SKUID)) {
                      products[sku.SKUID][0] += mtd;
                    } else {
                      products.addAll({
                        sku.SKUID: [mtd, 0]
                      });
                    }

                  });
                }
              } else if (int.parse(
                          aDistributorOrder.dateAndTime.substring(5, 7)) -
                      1 ==
                  int.parse(time.substring(5, 7))) {
                if (int.parse(aDistributorOrder.dateAndTime.substring(8, 10)) >
                    int.parse(time.substring(8, 10))) {
                  distributorOrderItem
                      .where((element) =>
                          element.distributorOrderID ==
                          aDistributorOrder.distributorOrderID)
                      .forEach((aDistributorOrderItem) {
                    SKU sku = SKU(aDistributorOrderItem.SKUID, "", 1, 1, 1, 1, 0, 0, 0, 0, 0, "", 0, "", true);
                    try {
                      sku = allSKULocal.firstWhere(
                          (e) => e.SKUID == aDistributorOrderItem.SKUID);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "SKU NOT FOUND, Please contact IT"),
                        ),
                      );
                    }
                    mtd += sku.MRP *
                            aDistributorOrderItem.primaryItemCount *
                            sku.primaryCF +
                        sku.MRP *
                            aDistributorOrderItem.alternativeItemCount *
                            sku.alternativeCF;

                    if (products.containsKey(sku.SKUID)) {
                      products[sku.SKUID][0] += mtd;
                    } else {
                      products.addAll({
                        sku.SKUID: [mtd, 0]
                      });
                    }

                  });
                }
              }
            }
            //FOR YTD
            if (aDistributorOrder.dateAndTime.substring(0, 4) ==
                time.substring(0, 4)) {
              if (int.parse(aDistributorOrder.dateAndTime.substring(5, 7)) <=
                  int.parse(time.substring(5, 7))) {
                distributorOrderItem
                    .where((element) =>
                        element.distributorOrderID ==
                        aDistributorOrder.distributorOrderID)
                    .forEach((aDistributorOrderItem) {

                  SKU sku = SKU(1, "", 1, 1, 1, 1, 1, 1, 1, 1, 1, "", 1, "", true);
                  try{
                    SKU sku = allSKULocal.firstWhere(
                        (e) => e.SKUID == aDistributorOrderItem.SKUID);
                  } catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("NO SKU FOUND, Please Contact IT", ),));

                  }
                  ytd += sku.MRP *
                          aDistributorOrderItem.primaryItemCount *
                          sku.primaryCF +
                      sku.MRP *
                          aDistributorOrderItem.alternativeItemCount *
                          sku.alternativeCF;

                  if (products.containsKey(sku.SKUID)) {
                    products[sku.SKUID][1] += ytd;
                  } else {
                    products.addAll({
                      sku.SKUID: [0, ytd]
                    });
                  }
                });
              }
            } else if (int.parse(
                        aDistributorOrder.dateAndTime.substring(0, 4)) -
                    1 ==
                int.parse(time.substring(0, 4))) {
              if (int.parse(aDistributorOrder.dateAndTime.substring(5, 7)) >
                  int.parse(time.substring(5, 7))) {
                distributorOrderItem
                    .where((element) =>
                        element.distributorOrderID ==
                        aDistributorOrder.distributorOrderID)
                    .forEach((aDistributorOrderItem) {
                  SKU sku = SKU(1, "", 1, 1, 1, 1, 1, 1, 1, 1, 1, "", 1, "", true);
                 try {
                    sku = allSKULocal.firstWhere(
                        (e) => e.SKUID == aDistributorOrderItem.SKUID);
                  }catch(e) {
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("NO SKU FOUND, Please contact IT,", ),));
                 }
                  ytd += sku.MRP *
                          aDistributorOrderItem.primaryItemCount *
                          sku.primaryCF +
                      sku.MRP *
                          aDistributorOrderItem.alternativeItemCount *
                          sku.alternativeCF;

                  if (products.containsKey(sku.SKUID)) {
                    products[sku.SKUID][1] += ytd;
                  } else {
                    products.addAll({
                      sku.SKUID: [0, ytd]
                    });
                  }
                });
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
        setLoaded();
      });
    });
  });
}
