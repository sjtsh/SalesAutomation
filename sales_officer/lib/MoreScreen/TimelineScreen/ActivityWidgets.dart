import 'package:flutter/material.dart';

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
  final int quantity;

  OrderStockActivity(
      this.isOrder, this.distributorName, this.amount, this.quantity);

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
                  Text(quantity.toString()),
                ],
              ),
              Expanded(child: Container()),
              Container(
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
                    onTap: () {},
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
            ],
          ),
        ],
      ),
    );
  }
}
