import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND/Methods/method.dart';
import 'package:sales_officer/DistributorInfo.dart';
import 'package:sales_officer/NavBar/NavBar.dart';
import 'package:sales_officer/StocksScreen/StocksScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ProductsScreen/ProductsScreen.dart';

List colors = [Color(0xff7DDF5B), Color(0xffE86068), Color(0xff61ABEF)];

class DistributorList extends StatelessWidget {
  final Distributor distributor;
  final bool isOrder;
  final bool isStock;
  final int index;

  DistributorList(
    this.distributor,
    this.isOrder,
    this.isStock,
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () async {
          if (isOrder) {
            NavBar.onItemTapped(5);
            if (isStock) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return StocksScreen(
                      distributor,
                      index,
                      DistributorOrder(
                          -1, -1, -1, true, false, "", "", "", 0, 0),
                    );
                  },
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return ProductsScreen(
                      distributor,
                      index,
                      DistributorOrder(
                          -1, -1, -1, true, false, "", "", "", 0, 0),
                      true,
                    );
                  },
                ),
              );
            }
          } else {
            NavBar.onItemTapped(6);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return DistributorInfo(distributor);
                },
              ),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
          ),
          child: Row(
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
                )),
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
                              fontSize: 12, color: Colors.black.withOpacity(0.5)),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    MaterialButton(
                        onPressed: () =>
                            launch("tel:+977${distributor.mobileNumber.toString()}"),
                        child: Icon(Icons.call)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
