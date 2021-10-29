import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorSale.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderItemService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/NepaliDateService.dart';

import '../../Database.dart';

calculateSales() {
  NepaliDateService nepaliDateService = NepaliDateService();
  nepaliDateService.fetchNepaliDate().then((time) {
    DistributorOrderService distributorOrderService = DistributorOrderService();
    distributorOrderService.fetchDistributorOrders().then((distributorOrder) {
      DistributorOrderItemService distributorOrderItemService =
          DistributorOrderItemService();
      distributorOrderItemService
          .fetchDistributorOrderItems()
          .then((distributorOrderItem) {
        personalDistributorsLocal.forEach((aDistributor) {
          double mtd = 0;
          double ytd = 0;
          distributorOrder
              .where((aDistributorOrder) =>
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
                    SKU sku = allSKULocal.firstWhere(
                        (e) => e.SKUID == aDistributorOrderItem.SKUID);
                    mtd += sku.MRP *
                            aDistributorOrderItem.primaryItemCount *
                            sku.primaryCF +
                        sku.MRP *
                            aDistributorOrderItem.alternativeItemCount *
                            sku.alternativeCF;
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
                    SKU sku = allSKULocal.firstWhere(
                        (e) => e.SKUID == aDistributorOrderItem.SKUID);
                    mtd += sku.MRP *
                            aDistributorOrderItem.primaryItemCount *
                            sku.primaryCF +
                        sku.MRP *
                            aDistributorOrderItem.alternativeItemCount *
                            sku.alternativeCF;
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
                  SKU sku = allSKULocal.firstWhere(
                      (e) => e.SKUID == aDistributorOrderItem.SKUID);
                  ytd += sku.MRP *
                          aDistributorOrderItem.primaryItemCount *
                          sku.primaryCF +
                      sku.MRP *
                          aDistributorOrderItem.alternativeItemCount *
                          sku.alternativeCF;
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
                  SKU sku = allSKULocal.firstWhere(
                      (e) => e.SKUID == aDistributorOrderItem.SKUID);
                  ytd += sku.MRP *
                          aDistributorOrderItem.primaryItemCount *
                          sku.primaryCF +
                      sku.MRP *
                          aDistributorOrderItem.alternativeItemCount *
                          sku.alternativeCF;
                });
              }
            }
          });
          String lastOrder = "None";
          List<DistributorOrder> distributorOrders = distributorOrder
              .where((aDistributorOrder) =>
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
          print(aDistributor.distributorID.toString() + " " + mtd.toString() + " " + ytd.toString());
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
