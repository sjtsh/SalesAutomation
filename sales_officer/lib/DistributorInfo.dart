import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'BACKEND Access/Entities/Distributor.dart';
import 'BACKEND Access/Entities/DistributorOrder.dart';
import 'BACKEND Access/Methods/method.dart';
import 'ProductsScreen/ProductsScreen.dart';
import 'StocksScreen/StocksScreen.dart';

class DistributorInfo extends StatelessWidget {
  final Distributor currentDistributor;

  final Function refresh;


  DistributorInfo(this.currentDistributor, this.refresh);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 3,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return ProductsScreen(
                                currentDistributor,
                                2,
                                DistributorOrder(
                                    -1, -1, -1, true, false, "", "", "", 0, 0, false),
                                true,
                                refresh,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        color: Color(0xff60D74D),
                        child: Builder(builder: (context) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bookmark_border,
                                color: Colors.white,
                                size: 25,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "Add Order",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 3,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return StocksScreen(
                                currentDistributor,
                                1,
                                DistributorOrder(
                                    -1, -1, -1, true, false, "", "", "", 0, 0, false),
                                refresh,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        color: Colors.blue,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.production_quantity_limits,
                                color: Colors.white,
                                size: 25,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "Add Stock",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      getInitials(currentDistributor.distributorName),
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.5)),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        currentDistributor.distributorName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Column(
                      children: [
                        ["Name: ", currentDistributor.distributorName],
                        ["Owner Name: ", currentDistributor.ownerName],
                        ["Phone Number: ", currentDistributor.phone.toString()],
                        [
                          "Mobile Number: ",
                          currentDistributor.mobileNumber.toString()
                        ],
                        ["PAN Number: ", currentDistributor.PAN.toString()],
                        ["Address: ", currentDistributor.location],
                        [
                          "Bank Account Name: ",
                          currentDistributor.bankAccountName
                        ],
                        [
                          "Bank Account Number: ",
                          currentDistributor.bankAccountNumber.toString()
                        ],
                        ["Bank Address: ", currentDistributor.bankAddress],
                        ["VAT Number: ", currentDistributor.VAT.toString()],
                        [
                          "Geo: ",
                          currentDistributor.lat.toString() +
                              ", " +
                              currentDistributor.lng.toString()
                        ],
                      ]
                          .map((e) => Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Row(
                                      children: [
                                        Text(e[0]),
                                        Expanded(child: Container()),
                                        Text(
                                          e[1],
                                          style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.7)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: [
                          Text("Assigned Beat: "),
                          Expanded(child: Container()),
                          Text(
                            "Dhumbarahi Beat 1",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Wrap(
                      children: [
                        "Beat1",
                        "Beat2",
                        "Beat3",
                        "Beat4",
                        "Beat5",
                        "Beat6"
                      ]
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xffe0e0e0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 8),
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            color: Color(0xffF5F5F5),
                            child: Builder(builder: (context) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                  Text(
                                    "MORE FIELDS",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 74,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
