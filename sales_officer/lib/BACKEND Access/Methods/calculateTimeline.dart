import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrderItem.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUStock.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUStockTrack.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SOActivity.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SOLogInDetail.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderItemService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/NepaliDateService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SKUStockService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SKUStockTrackService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SOActivityService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SOLogInDetailService.dart';
import 'package:sales_officer/MoreScreen/TimelineScreen/ActivityWidgets.dart';

import '../../Database.dart';

Future<List> calculateTimeline(context) async {
  String date = await NepaliDateService().fetchNepaliDate();
  List<DistributorOrderItem> distributorOrderItems =
      await DistributorOrderItemService().fetchDistributorOrderItems(context);
  List<DistributorOrder> allOrders =
      await DistributorOrderService().fetchDistributorOrders(context);
  List<SKUStockTrack> allStocks =
      await SKUStockTrackService().fetchSKUStockTrack();
  List<SOLogInDetail> allDetails =
      await SOLogInDetailService().fetchSOLogInDetails();
  List<SOActivity> allActivity = await SOActivityService().fetchSOActivitys();
  List<SKUStock> allSKUStocks = await SKUStockService().fetchSKUStocks();

  List activityByTime = [];
  List<DistributorOrder> allOrdersToday = allOrders
      .where((element) =>
          element.dateAndTime.substring(0, 10) == date.substring(0, 10))
      .toList();
  allOrdersToday.forEach((order) {
    double totalAmount = 0;
    int primaryQuantity = 0;
    int alternativeQuantity = 0;
    distributorOrderItems
        .where(
            (element) => element.distributorOrderID == order.distributorOrderID)
        .forEach((element) {
      SKU mySKU = allSKULocal.firstWhere((sku) => sku.SKUID == element.SKUID);
      totalAmount += mySKU.MRP * element.primaryItemCount * mySKU.primaryCF +
          mySKU.MRP * element.alternativeItemCount * mySKU.alternativeCF;
      primaryQuantity += element.primaryItemCount;
      alternativeQuantity += element.alternativeItemCount;
    });
    activityByTime.add([
      order.dateAndTime,
      "Distributor Order",
      OrderStockActivity(
          true,
          allDistributorsLocal
              .firstWhere(
                  (element) => element.distributorID == order.distributorID)
              .distributorName,
          totalAmount,
          primaryQuantity,
          alternativeQuantity,
          order)
    ]);
  });
  List<SKUStockTrack> allStocksToday = allStocks
      .where((element) =>
          element.dateAndTime.substring(0, 10) == date.substring(0, 10))
      .toList();
  allStocksToday.forEach((stock) {
    Distributor myDistributor = allDistributorsLocal
        .firstWhere((element) => element.distributorID == stock.distributorID);
    activityByTime.add([
      stock.dateAndTime,
      "Distributor Stock",
      OrderStockActivity(false, myDistributor.distributorName, 0, 0, 0, [
        myDistributor,
        allSKUStocks
            .where((element) => element.distributorID == stock.distributorID)
            .toList()
      ])
    ]);
  });
  List<SOLogInDetail> allDetailsToday = allDetails
      .where(
          (element) => element.date.substring(0, 10) == date.substring(0, 10))
      .toList();
  allDetailsToday.forEach((element) {
    activityByTime.add([
      (element.date + " " + element.logInTime.padLeft(8, "0")),
      "Day Start",
      LogInOutActivity(true, element.logInLat, element.logInLng)
    ]);
    if (element.logOutTime != null) {
      activityByTime.add([
        element.date + " " + element.logOutTime!.padLeft(8, "0"),
        "Day End",
        LogInOutActivity(false, element.logOutLat!, element.logOutLng!)
      ]);
    }
  });
  List<SOActivity> allActivities = allActivity
      .where((element) =>
          element.dateAndTime.substring(0, 10) == date.substring(0, 10))
      .toList();
  allActivities.forEach((activity) {
    activityByTime.add([
      activity.dateAndTime,
      "Activity Update",
      ActivityUpdate(
          allDistributorsLocal
              .firstWhere(
                  (element) => element.distributorID == activity.distributorID)
              .distributorName,
          activity.remark,
          allTaskLocal
              .firstWhere((element) => activity.taskID == element.taskID)
              .taskName)
    ]);
  });
  return activityByTime;
}
