import 'package:flutter/material.dart';
import 'package:sales_officer/MoreScreen/ViewStockScreen/SingularStockScreen.dart';
import 'package:sales_officer/PendingScreen/OrderItemsScreen.dart';
import 'package:sales_officer/PendingScreen/SingularPending.dart';

class LogInOutActivity extends StatelessWidget {
  final bool isLogIn;
  final double lat;
  final double lng;

  LogInOutActivity(this.isLogIn, this.lat, this.lng);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text("Location . Sukedhara, Kathmandu"),
    );
  }
}

class ActivityUpdate extends StatelessWidget {
  final String distributorName;
  final String remark;
  final String taskName;

  ActivityUpdate(this.distributorName, this.remark, this.taskName);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$distributorName - $taskName"),
          Text("$remark"),
        ],
      ),
    );
  }
}

class OrderStockActivity extends StatelessWidget {
  final bool isOrder;
  final String distributorName;
  final double amount;
  final int primaryQuantity;
  final int alternativeQuantity;
  final distributorOrder;

  OrderStockActivity(this.isOrder, this.distributorName, this.amount,
      this.primaryQuantity, this.alternativeQuantity, this.distributorOrder);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            distributorName,
            style: TextStyle(color: Colors.black),
          ),
          Row(
            children: [
              isOrder
                  ? Expanded(
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${isOrder ? "Order" : "Stock"} Value"),
                              Text(amount.toString()),
                            ],
                          ),
                          Expanded(child: Container()),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Qty"),
                              Text(
                                  "${primaryQuantity}PU ${alternativeQuantity}AU"),
                            ],
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                    )
                  : Container(),
              Expanded(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        if (isOrder) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) {
                              return ApproveOrderScreen(
                                  distributorOrder, () {});
                            }),
                          );
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (_){
                            return SingularStockScreen(
                                distributorOrder[0], distributorOrder[1]);
                          }));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color(0xff9b9b9b),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "View Details",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
