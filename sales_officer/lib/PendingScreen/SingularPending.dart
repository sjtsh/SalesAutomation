import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/method.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/shareOrder.dart';
import 'package:sales_officer/Database.dart';
import 'package:sales_officer/PendingScreen/OrderItemsScreen.dart';
import 'package:sales_officer/ProductsScreen/ProductsScreen.dart';

class SingularPending extends StatefulWidget {
  final DistributorOrder e;
  final Function refresh;

  SingularPending(this.e, this.refresh);

  @override
  State<SingularPending> createState() => _SingularPendingState();
}

class _SingularPendingState extends State<SingularPending> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Distributor distributor = allDistributorsLocal
        .where((element) => element.distributorID == widget.e.distributorID)
        .first;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: double.infinity,
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
        child: !isLoading
            ? Material(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return ApproveOrderScreen(widget.e, widget.refresh);
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                width: 10,
                              ),
                              Text(
                                distributor.distributorName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
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
                              Expanded(
                                child: Container(),
                              ),
                              !widget.e.orderStatus
                                  ? PopupMenuButton(
                                      onSelected: (option) {
                                        if (option == 1) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (_) {
                                              return ProductsScreen(
                                                  distributor,
                                                  6,
                                                  widget.e,
                                                  false,
                                                  widget.refresh);
                                            }),
                                          );
                                        } else if (option == 2) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          shareOrder(widget.e, context);
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          PopupMenuItem(
                                              value: 1,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.edit),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(child: Text("Edit")),
                                                ],
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                              )),
                                          PopupMenuItem(
                                              value: 2,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.share),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                      child: Text("Share")),
                                                ],
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                              )),
                                        ];
                                      },
                                    )
                                  : PopupMenuButton(
                                      onSelected: (option) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        shareOrder(widget.e, context);
                                        setState(() {
                                          isLoading = false;
                                        });
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          PopupMenuItem(
                                              value: 2,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.share),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                      child: Text("Share")),
                                                ],
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                              )),
                                        ];
                                      },
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
                          ]
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 5),
                                  child: e[1] == "null" || e[1] == "-1"
                                      ? Container()
                                      : Row(
                                          children: [
                                            Text(
                                              e[0],
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            Expanded(child: Container()),
                                            Text(
                                              e[1],
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
                ),
              )
            : SizedBox(
                height: 200, child: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
