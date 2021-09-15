import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/SubGroup.dart';
import 'package:sales_officer/DialogBox/ProductDialogBox.dart';

class SingularProductHeader extends StatelessWidget {
  final SubGroup subGroup;
  final Function changeCurrentlyExpanded;

  SingularProductHeader(this.subGroup, this.changeCurrentlyExpanded);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          changeCurrentlyExpanded(subGroup.subGroupID);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
          ),
          child: Container(
            height: 60,
            margin: EdgeInsets.all(12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return ProductDialogBox(subGroup);
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 60,
                            width: 52,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.1),
                            ),
                            child: Image.asset(
                              "products/kurumkurumchiura.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 52,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.15),
                                shape: BoxShape.circle),
                            child: Center(
                              child: Icon(
                                Icons.zoom_in,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  subGroup.productGroupName,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 1),
                                    child: Text(
                                      subGroup.productLineName.substring(0, 1) +
                                          subGroup.productLineName.substring(
                                              subGroup.productLineName.length -
                                                  1,
                                              subGroup.productLineName.length),
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              subGroup.subGroupName,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      SizedBox(
                        width: 12,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
