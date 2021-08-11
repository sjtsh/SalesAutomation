import 'package:flutter/material.dart';
import 'package:sales_officer/DistributorInfo.dart';
import 'package:sales_officer/NavBar/NavBar.dart';

import '../Database.dart';
import 'NewOrder.dart';
import '../ProductsScreen/ProductsScreen.dart';

List colors = [Color(0xff7DDF5B), Color(0xffE86068), Color(0xff61ABEF)];
class DistributorList extends StatelessWidget {
  final item;
  final bool isOrder;
  final int index;

  DistributorList(this.item, this.isOrder, this.index);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        if (isOrder) {
          print("4 into 5");
          NavBar.onItemTapped(5);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return ProductsScreen(item, index);
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
                return DistributorInfo(item);
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
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 2),
              blurRadius: 3,
            ),
          ],
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
                item.split(" ")[0].substring(0, 1) +
                    item.split(" ")[1].substring(0, 1),
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
                "$item",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
