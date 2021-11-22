import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUStock.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/method.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SKUStockService.dart';
import 'package:sales_officer/MoreScreen/ViewStockScreen/SingularStockScreen.dart';

import '../../Database.dart';
import '../../Header.dart';

class ViewStock extends StatelessWidget {
  final Function refresh;

  ViewStock(this.refresh);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Header(15, false, refresh),
            FutureBuilder(
                future: SKUStockService().fetchSKUStocks(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    print("data found");
                    allSKUStocksLocal = snapshot.data;
                    return Column(
                      children: personalDistributorsLocal
                          .where((element) => element.distributorName != "null")
                          .map((item) {
                        List<SKUStock> myDistributorStocks = allSKUStocksLocal
                            .where((element) =>
                                element.distributorID == item.distributorID)
                            .toList();
                        double totalValue = 0;
                        int totalPrimaryUnit = 0;
                        int totalAlternativeUnit = 0;
                        DateTime lastUpdatedDate = DateTime(0);
                        myDistributorStocks.forEach((stock) {
                          try {
                            SKU mySKU = allSKULocal.firstWhere(
                                (element) => element.SKUID == stock.SKUID);
                            totalValue += mySKU.MRP *
                                    stock.primaryStock *
                                    mySKU.primaryCF +
                                mySKU.MRP *
                                    stock.alternativeStock *
                                    mySKU.alternativeCF;
                            totalPrimaryUnit += stock.primaryStock;
                            totalAlternativeUnit += stock.alternativeStock;
                            if (lastUpdatedDate
                                .isBefore(DateTime.parse(stock.updatedDate))) {
                              lastUpdatedDate =
                                  DateTime.parse(stock.updatedDate);
                            }
                          } catch (e) {}
                        });
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 2),
                                  blurRadius: 3,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Material(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return SingularStockScreen(
                                        item, myDistributorStocks);
                                  }));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  alignment: Alignment.centerLeft,
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.green,
                                            ),
                                            child: Center(
                                              child: Text(
                                                getInitials(
                                                    item.distributorName),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${item.distributorName}",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    item.location == "null"
                                                        ? Text("")
                                                        : Text(
                                                            item.location,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5)),
                                                          ),
                                                  ],
                                                ),
                                                Expanded(child: Container()),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Value: $totalValue",
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                          ),
                                          Expanded(child: Container()),
                                          Text(
                                            "Quantity: $totalPrimaryUnit PU $totalAlternativeUnit AU",
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Taken by: ",
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                          ),
                                          Expanded(child: Container()),
                                          Text(
                                            "Taken on: ${lastUpdatedDate.toString().substring(0, 10)}",
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                  return Column(
                    children: personalDistributorsLocal
                        .where((element) => element.distributorName != "null")
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 2),
                                    blurRadius: 3,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(12),
                                alignment: Alignment.centerLeft,
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green,
                                          ),
                                          child: Center(
                                            child: Text(
                                              getInitials(item.distributorName),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${item.distributorName}",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  item.location == "null"
                                                      ? Text("")
                                                      : Text(
                                                          item.location,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5)),
                                                        ),
                                                ],
                                              ),
                                              Expanded(child: Container()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Value: 0",
                                          style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                        Expanded(child: Container()),
                                        Text(
                                          "Quantity: 0",
                                          style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Taken by: ",
                                          style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                        Expanded(child: Container()),
                                        Text(
                                          "Taken on: ",
                                          style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
