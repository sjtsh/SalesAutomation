import 'package:flutter/material.dart';
import 'package:sales_officer/NavBar/NavBar.dart';

import 'NewOrder.dart';

class DistributorList extends StatelessWidget {
  final Function _setIndex;
  final item;
  final bool isOrder;

  DistributorList(this._setIndex, this.item, this.isOrder);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ProductsScreen(),
              // )
              // );
              if(isOrder){
                print("4 into 5");
                currentDistributor = item;
                NavBar.onItemTapped(5);
                _setIndex(5);
              }else{
                print("4 into 5");
                currentDistributor = item;
                NavBar.onItemTapped(6);
                _setIndex(6);
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
                      color: Color(0xffEA47B2),
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
