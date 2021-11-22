import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/method.dart';

class DistributorLists extends StatelessWidget {
  final Function tap;
  final bool onTapped;
  final Distributor _distributor;

  DistributorLists(this.tap, this.onTapped, this._distributor);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        tap(onTapped);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(12),
          border:
          Border.all(color: Colors.black),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                Colors.lightGreenAccent,
              ),
              child: Center(
                child: Text(
                  getInitials(
                      _distributor.distributorName),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight:
                      FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "${_distributor.distributorName}",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Expanded(child: Container()),
            Stack(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        shape:
                        BoxShape.circle,
                        color: onTapped
                            ? Colors.red
                            : Colors
                            .transparent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
