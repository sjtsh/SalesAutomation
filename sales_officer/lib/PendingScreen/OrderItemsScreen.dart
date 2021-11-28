import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrderItem.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/mapsIntent.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/method.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/shareOrder.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderItemService.dart';
import 'package:sales_officer/BreadCrum/BreadCrum.dart';
import 'package:sales_officer/Database.dart';
import 'package:sales_officer/Header.dart';
import 'package:sales_officer/PendingScreen/OrderItemsExpanded.dart';
import 'package:sales_officer/PendingScreen/OrderItemsHeader.dart';
import 'package:sales_officer/ProductsScreen/ProductsScreen.dart';

class ApproveOrderScreen extends StatefulWidget {
  final DistributorOrder e;
  final Function refresh;

  ApproveOrderScreen(this.e, this.refresh);

  @override
  _ApproveOrderScreenState createState() => _ApproveOrderScreenState();
}

class _ApproveOrderScreenState extends State<ApproveOrderScreen> {
  List<DistributorOrderItem> distributorOrderItems = [];
  double totalAmount = 0;
  bool isLoading = true;

  List<SKUDistributorWise> skuDistributorWises = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allSKUDistributorWiseLocal.forEach((i) {
      if (i.distributorID == widget.e.distributorID) {
        skuDistributorWises.add(i);
      }
    });
    DistributorOrderItemService distributorOrderItemService =
        DistributorOrderItemService();
    distributorOrderItemService.fetchDistributorOrderItems(context).then((value) {
      List<DistributorOrderItem> aList = [];
      value.forEach((element) {
        if (element.distributorOrderID == widget.e.distributorOrderID) {
          aList.add(element);
          SKU sku =
              allSKULocal.firstWhere((i) => i.SKUID == element.SKUID);
          totalAmount += element.primaryItemCount *
              sku.primaryCF *
              sku.MRP;
          totalAmount += element.alternativeItemCount *
              sku.alternativeCF *
              sku.MRP;
          totalAmount += element.secondaryAlternativeItemCount *
              sku.secondaryAlternativeCF *
              sku.MRP;
        }
      });
      setState(() {
        distributorOrderItems = aList;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Distributor distributor = allDistributorsLocal
        .where((element) => element.distributorID == widget.e.distributorID)
        .first;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: !widget.e.orderStatus ? Row(
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
                          MaterialPageRoute(builder: (_) {
                            return ProductsScreen(
                              distributor,
                              6,
                              widget.e,
                              false,
                              widget.refresh
                            );
                          }),
                        );
                      },
                      child: Container(
                        height: 50,
                        color: Colors.green,
                        child: Builder(builder: (context) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 25,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "Edit",
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
                        setState(() {
                          isLoading = true;
                        });
                        shareOrder(widget.e,context);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Container(
                        height: 50,
                        color: Colors.blue,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 25,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "Share",
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
          ) : Container(
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
                  setState(() {
                    isLoading = true;
                  });
                  shareOrder(widget.e,context);
                  setState(() {
                    isLoading = false;
                  });
                },
                child: Container(
                  height: 50,
                  color: Colors.blue,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.share,
                          color: Colors.white,
                          size: 25,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Share",
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
        body: Column(
          children: [
            Header(2, false, widget.refresh),
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
              child: BreadCrum2(widget.e.orderStatus ? "Approved Orders" : "Pending Orders", distributor.distributorName),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
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
                                          getInitials(distributor.distributorName),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 8),
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
                                        color: widget.e.orderStatus
                                            ? Color(0xff60D74D)
                                            : Color(0xffFFCE31),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          widget.e.orderStatus
                                              ? "APPROVED"
                                              : "PENDING",
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
                                  [
                                    "Order ID :",
                                    "#OR${widget.e.distributorOrderID.toString().padLeft(4, '0')}"
                                  ],
                                  ["Date :", "${widget.e.dateAndTime}"],
                                  ["Last Updated :", widget.e.updatedTime],
                                  [
                                    "Status :",
                                    widget.e.orderStatus ? "Approved" : "Pending"
                                  ],
                                  [
                                    "Representation :",
                                    widget.e.joint ? "Joint" : "Single"
                                  ],
                                  ["Remarks :", "${widget.e.remarks}"],
                                ]
                                    .map(
                                      (e) => e[1] == "null" || e[1]=="-1" || e[1] =="-2000.0, -2000.0" ? Container() :
                                      Column(
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

                              Column(
                                children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 12),
                                    child: Row(
                                      children: [
                                        Text("Geo: "),
                                        Expanded(child: Container()),
                                        Container(
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Material(
                                            color: Colors.white,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: Colors.blue),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                    MapUtils.openMap(widget.e.lat,
                                                        widget.e.lng, context);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: 3, bottom: 3, right: 8, left: 8),
                                                  child: Builder(builder: (context) {
                                                    return Center(
                                                      child: Text(
                                                        "View on Maps",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12),
                                                      ),
                                                    );
                                                  }),
                                                ),
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
                                ],
                              ),
                              ExpandablePanel(
                                collapsed: OrderItemsHeader(),
                                expanded: isLoading
                                    ? Column(
                                        children: [
                                          OrderItemsHeader(),
                                          Container(
                                              height: 100,
                                              color: Colors.white,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator())),
                                          Divider(
                                            color: Colors.black.withOpacity(0.1),
                                            thickness: 1,
                                          ),
                                        ],
                                      )
                                    : OrderItemsExpanded(
                                        distributorOrderItems, skuDistributorWises),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 12),
                                child: Row(
                                  children: [
                                    Text("Total Amount"),
                                    Expanded(child: Container()),
                                    Text(
                                      "Rs $totalAmount",
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

                    SizedBox(height: 74),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
