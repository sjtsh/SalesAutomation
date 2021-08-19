import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrder.dart';
import 'package:sales_officer/BreadCrum/BreadCrum.dart';
import 'package:sales_officer/Database.dart';
import 'package:sales_officer/Header.dart';

class ApproveOrderScreen extends StatelessWidget {
  final DistributorOrder e;

  ApproveOrderScreen(this.e);

  @override
  Widget build(BuildContext context) {
    Distributor distributor = allDistributorsLocal
        .where((element) => element.distributorID == e.distributorID)
        .first;
    return Scaffold(
      body: Column(
        children: [
          Header(3, false),
          Container(
            padding: EdgeInsets.only(left: 12),
            alignment: Alignment.centerLeft,
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.black.withOpacity(0.1),
                ),
                bottom: BorderSide(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: BreadCrum2("Pending Orders", distributor.distributorName),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 3,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 12),
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffEA47B2),
                                ),
                                child: Center(
                                  child: Text(
                                    distributor.distributorName
                                            .split(" ")[0]
                                            .substring(0, 1) +
                                        distributor.distributorName
                                            .split(" ")[1]
                                            .substring(0, 1),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                distributor.distributorName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(child: Container()),
                              Container(
                                decoration: BoxDecoration(
                                  color: e.orderStatus
                                      ? Color(0xffFFCE31)
                                      : Color(0xff60D74D),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    e.orderStatus ? "PENDING" : "APPROVED",
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.1),
                          thickness: 1,
                        ),
                        Column(
                          children: [
                            ["Order ID :", "#OR${e.distributorOrderID}"],
                            ["Date :", "${e.dateAndTime}"],
                            [
                              "Status :",
                              e.orderStatus ? "Pending" : "Approved"
                            ],
                            ["Representation :", e.joint ? "Joint" : "Single"],
                            ["Remarks :", "${e.remarks}"],
                          ]
                              .map(
                                (e) => Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 12),
                                      child: Row(
                                        children: [
                                          Text(e[0]),
                                          Expanded(child: Container()),
                                          Text(
                                            e[1],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black.withOpacity(0.1),
                                      thickness: 1,
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                        ExpandablePanel(
                          collapsed: Column(
                            children: [
                              ExpandableButton(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      Text("Order List"),
                                      Expanded(
                                        child: Container(),
                                      ),
                                      Icon(Icons.keyboard_arrow_down_rounded),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.black.withOpacity(0.1),
                                thickness: 1,
                              ),
                            ],
                          ),
                          expanded: Column(
                            children: [
                              ExpandableButton(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 12),
                                  child: Row(
                                    children: [
                                      Text("Order List"),
                                      Expanded(
                                        child: Container(),
                                      ),
                                      Icon(Icons.keyboard_arrow_down_rounded),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: allSubGroupsLocal
                                    .sublist(0, 3)
                                    .map(
                                      (e) => Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xffF5F5F5),
                                          border: Border(
                                            bottom: BorderSide(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                            ),
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 12),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  e.subGroupName,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                Text(
                                                  productVariations[1],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            Expanded(child: Container()),
                                            Text(
                                               "10 Pcs",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 12),
                          child: Row(
                            children: [
                              Text("Total Amount"),
                              Expanded(child: Container()),
                              Text(
                                "Rs 1000}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          e.orderStatus? Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xff60D74D),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Approve Order",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffE85050),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text("Reject Order",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
              SizedBox(
                height: 6,
              ),
            ],
          ):Container(),

        ],
      ),
    );
  }
}
