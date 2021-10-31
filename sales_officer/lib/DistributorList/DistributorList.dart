import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorSale.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/method.dart';
import 'package:sales_officer/DistributorInfo.dart';
import 'package:sales_officer/StocksScreen/StocksScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Database.dart';
import '../ProductsScreen/ProductsScreen.dart';

List<Color> colors = <Color>[
  Color(0xff7DDF5B),
  Color(0xffE86068),
  Color(0xff61ABEF)
];
List<Color> colorOpacity = <Color>[
  Color(0xffF2FCEF),
  Color(0xffFDEEEE),
  Color(0xffF0F7FE)
];

class DistributorList extends StatelessWidget {
  final Distributor distributor;
  final int index;

  final Function refresh;

  DistributorList(this.distributor, this.index, this.refresh);

  @override
  Widget build(BuildContext context) {
    DistributorSale distributorSales = allDistributorSalesLocal.firstWhere(
        (element) =>
            element.distributor.distributorID == distributor.distributorID);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12.0),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return DistributorInfo(distributor, refresh);
                  },
                ),
              );
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
                            color: colors[index],
                          ),
                          child: Center(
                            child: Text(
                              getInitials(distributor.distributorName),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${distributor.distributorName}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    distributor.location,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: colors[index],
                                        blurRadius: .5,
                                      ),
                                    ]),
                                child: Material(
                                  color: colorOpacity[index],
                                  clipBehavior: Clip.hardEdge,
                                  shape: CircleBorder(),
                                  child: InkWell(
                                    onTap: () => launch(
                                        "tel:+977${distributor.mobileNumber.toString()}"),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.call,
                                        color: colors[index],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.black.withOpacity(0.1),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                    color: Color(0xff60D74D).withOpacity(0.2),
                                    shape: BoxShape.circle),
                                child: Icon(Icons.calendar_today,
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "MTD Sales",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  Text(
                                    "${distributorSales.mtd}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                    color: Color(0xffF2B200).withOpacity(0.2),
                                    shape: BoxShape.circle),
                                child: Icon(Icons.calendar_today,
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "YTD Sales",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  Text(
                                    "${distributorSales.ytd}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                    color: Color(0xffEC2227).withOpacity(0.2),
                                    shape: BoxShape.circle),
                                child: Icon(Icons.monetization_on_outlined,
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Outstanding",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  Text(
                                    "${distributorSales.outstanding}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        color:
                                            Color(0xffEC2227).withOpacity(0.2),
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.access_time_sharp,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Last Order",
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),),
                                        ),
                                        Text(
                                          "${distributorSales.lastOrder}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.black.withOpacity(0.1),
                    ),
                    Row(
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
                                          distributor,
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
                                          distributor,
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
                        )
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
