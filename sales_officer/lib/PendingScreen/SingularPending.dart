import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND/Methods/method.dart';
import 'package:sales_officer/Database.dart';
import 'package:sales_officer/PendingScreen/OrderItemsScreen.dart';
import 'package:sales_officer/ProductsScreen/ProductsScreen.dart';

class SingularPending extends StatelessWidget {
  final DistributorOrder e;

  SingularPending(this.e);

  @override
  Widget build(BuildContext context) {
    Distributor distributor = allDistributorsLocal
        .where((element) => element.distributorID == e.distributorID)
        .first;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      child: RawMaterialButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return ApproveOrderScreen(e);
              },
            ),
          );
        },
        child: Container(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12),
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
                          color: e.orderStatus
                              ? Color(0xff60D74D)
                              : Color(0xffFFCE31),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            e.orderStatus ? "APPROVED" : "PENDING",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      PopupMenuButton(
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return ProductsScreen(
                                            distributor, 6, e, false);
                                      }));
                                    },
                                    child: Center(child: Text("Edit")))),
                            PopupMenuItem(
                                child: GestureDetector(
                                    onTap: () {},
                                    child: Center(child: Text("Share")))),
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
                    ["Order ID :", "#OR${e.distributorOrderID}"],
                    ["Date :", "${e.dateAndTime}"],
                  ]
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 5),
                          child: Row(
                            children: [
                              Text(
                                e[0],
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
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
      ),
    );
  }
}
