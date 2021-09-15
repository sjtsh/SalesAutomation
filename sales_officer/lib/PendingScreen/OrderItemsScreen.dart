import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrderItem.dart';
import 'package:sales_officer/BACKEND/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/BACKEND/Methods/method.dart';
import 'package:sales_officer/BACKEND/Services/DistributorOrderItemService.dart';
import 'package:sales_officer/BreadCrum/BreadCrum.dart';
import 'package:sales_officer/Database.dart';
import 'package:sales_officer/Header.dart';
import 'package:sales_officer/PendingScreen/OrderItemsExpanded.dart';
import 'package:sales_officer/PendingScreen/OrderItemsHeader.dart';

class ApproveOrderScreen extends StatefulWidget {
  final DistributorOrder e;

  ApproveOrderScreen(this.e);

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
    distributorOrderItemService.fetchDistributorOrderItems().then((value) {
      List<DistributorOrderItem> aList = [];
      value.forEach((element) {
        if (element.distributorOrderID == widget.e.distributorOrderID) {
          aList.add(element);
          SKUDistributorWise skuDistributorWise =
              skuDistributorWises.firstWhere((i) => i.SKUID == element.SKUID);
          totalAmount += element.primaryItemCount *
              skuDistributorWise.primaryCF *
              skuDistributorWise.MRP;
          totalAmount += element.alternativeItemCount *
              skuDistributorWise.alternativeCF *
              skuDistributorWise.MRP;
          totalAmount += element.secondaryAlternativeItemCount *
              skuDistributorWise.secondaryAlternativeCF *
              skuDistributorWise.MRP;
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
                              ["Order ID :", "#OR${widget.e.distributorOrderID}"],
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
                              ["Location :", "${widget.e.lat}, ${widget.e.lng}"]
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
