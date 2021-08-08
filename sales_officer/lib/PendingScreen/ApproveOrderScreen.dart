import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/Database.dart';
import 'package:sales_officer/Header/Header.dart';
import 'package:sales_officer/NewOrder/NewOrder.dart';
import 'package:sales_officer/Profile/BezierCard/ExpandableHeader.dart';

class ApproveOrderScreen extends StatelessWidget {
  final List e;

  ApproveOrderScreen(this.e);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Header(1),
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
              child: Row(
                children: [
                  Text(
                    "Pending Orders",
                    style: TextStyle(fontSize: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black.withOpacity(0.5),
                      size: 12,
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffEA47B2),
                    ),
                    child: Center(
                        child: Text(
                      e[0].split(" ")[0].substring(0, 1) +
                          e[0].split(" ")[1].substring(0, 1),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    )),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    e[0],
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
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
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
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
                                      e[0].split(" ")[0].substring(0, 1) +
                                          e[0].split(" ")[1].substring(0, 1),
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
                                  "Bihani Suppliers",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(child: Container()),
                                Container(
                                  decoration: BoxDecoration(
                                    color: e[4] as bool
                                        ? Color(0xffFFCE31)
                                        : Color(0xff60D74D),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      e[4] as bool ? "PENDING" : "APPROVED",
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Text("Order ID"),
                                Expanded(child: Container()),
                                Text(
                                  "#${e[1]}",
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black.withOpacity(0.1),
                            thickness: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Text("Order Date"),
                                Expanded(child: Container()),
                                Text(
                                  "${e[2]}",
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black.withOpacity(0.1),
                            thickness: 1,
                          ),
                          ExpandablePanel(
                            collapsed: Column(
                              children: [
                                ExpandableButton(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5.0),
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5.0),
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
                                  children: allProducts
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
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    e[1],
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
                                                e[2].toString() + " Pcs",
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
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Text("Total Amount"),
                                Expanded(child: Container()),
                                Text(
                                  "Rs ${e[3]}",
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
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xffE85050),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                    "Reject Order",
                    style: TextStyle(
                      color: Colors.white,
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
