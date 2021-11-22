import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUStock.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/method.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SKUStockService.dart';

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
            Column(
              children: personalDistributorsLocal
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
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return SafeArea(
                                  child: Scaffold(
                                    body: Column(
                                      children: [
                                        Header(15, false, refresh),
                                        Expanded(
                                          child: FutureBuilder(
                                              future: SKUStockService()
                                                  .fetchSKUStocks(),
                                              builder: (context,
                                                  AsyncSnapshot snapshot) {
                                                if (snapshot.hasData) {
                                                  return ListView(
                                                    children: [
                                                      Container(
                                                        margin:
                                                            EdgeInsets.all(12),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.1),
                                                                offset: Offset(
                                                                    0, 2),
                                                                blurRadius: 3),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Column(
                                                              children:
                                                                  allSubGroupsLocal
                                                                      .map(
                                                                        (e) =>
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            border:
                                                                                Border(
                                                                              bottom: BorderSide(
                                                                                color: Colors.black.withOpacity(0.1),
                                                                                width: 1,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              Container(
                                                                                padding: const EdgeInsets.only(
                                                                                  right: 20,
                                                                                  left: 20,
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
                                                                              Container(
                                                                                padding: const EdgeInsets.only(
                                                                                  right: 20,
                                                                                  left: 20,
                                                                                  bottom: 10,
                                                                                ),
                                                                                child: Column(
                                                                                  children: allSKULocal.where((element) => element.subGroupID == e.subGroupID).map((f) {
                                                                                    SKUStock skuStock;
                                                                                    try {
                                                                                      skuStock = allSKUStocksLocal.firstWhere((element) => element.SKUID == f.SKUID && element.distributorID == item.distributorID);
                                                                                    } catch (e) {
                                                                                      skuStock = SKUStock(0, f.SKUID, item.distributorID, 0, 0, 0, 0, "", 0, 0, true);
                                                                                    }

                                                                                    return Row(
                                                                                      children: [
                                                                                        Container(
                                                                                          width: MediaQuery.of(context).size.width / 2,
                                                                                          child: Text(
                                                                                            f.SKUName,
                                                                                            maxLines: 3,
                                                                                            style: TextStyle(
                                                                                              color: Colors.black.withOpacity(0.5),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Container(),
                                                                                        ),
                                                                                        Container(
                                                                                          child: Text(
                                                                                            skuStock.primaryStock.toString(),
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Container(),
                                                                                        ),
                                                                                        Container(
                                                                                          child: Text(
                                                                                            skuStock.alternativeStock.toString(),
                                                                                            maxLines: 3,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    );
                                                                                  }).toList(),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                      .toList(),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }));
                            },
                            child: Container(
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
                                                            color: Colors.black
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
