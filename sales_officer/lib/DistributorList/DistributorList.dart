import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND/Entities/SubGroup.dart';
import 'package:sales_officer/BACKEND/Methods/method.dart';
import 'package:sales_officer/BACKEND/Services/SubGroupService.dart';
import 'package:sales_officer/DistributorInfo.dart';
import 'package:sales_officer/NavBar/NavBar.dart';

import '../Database.dart';
import 'NewOrder.dart';
import '../ProductsScreen/ProductsScreen.dart';

List colors = [Color(0xff7DDF5B), Color(0xffE86068), Color(0xff61ABEF)];

class DistributorList extends StatelessWidget {
  final Distributor distributor;
  final bool isOrder;
  final bool isStock;
  final int index;

  DistributorList(this.distributor, this.isOrder, this.isStock, this.index);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () async {
          if (isOrder) {
            print("4 into 5");
            NavBar.onItemTapped(5);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return ProductsScreen(distributor, index, DistributorOrder(-1,-1,-1, true, false, "","","",0,0), true, isStock);
                },
              ),
            );
          } else {
            print("4 into 5");
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
                child: Text(
                  "${distributor.distributorName}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
