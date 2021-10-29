import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/method.dart';
import 'package:sales_officer/DistributorInfo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ProductsScreen/ProductsScreen.dart';

List<Color> colors = <Color>[
  Color(0xff7DDF5B),
  Color(0xffE86068),
  Color(0xff61ABEF)
];
List<Color> colorOpacity = <Color>[
  Color(0xffF2FCEF),
  Color(0xffFDEEEE),
  Color(0xffF0F7FE)
];

class DistributorList extends StatelessWidget {
  final Distributor distributor;
  final int index;

  final Function refresh;

  DistributorList(this.distributor, this.index, this.refresh);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 2),
              blurRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.hardEdge,
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return DistributorInfo(distributor, refresh);
                  },
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(12),
              alignment: Alignment.centerLeft,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                          ),
                        ),
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
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                              ],
                            ),
                            Expanded(child: Container()),
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: colors[index],
                                      blurRadius: .5,
                                    ),
                                  ]),
                              child: Material(
                                color: colorOpacity[index],
                                clipBehavior: Clip.hardEdge,
                                shape: CircleBorder(),
                                child: InkWell(
                                  onTap: () => launch(
                                      "tel:+977${distributor.mobileNumber.toString()}"),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.call,
                                      color: colors[index],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black.withOpacity(0.1),
                  ),
                  Text(
                    "mtd: , ytd: ",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    "Outstanding: 5000, Last Order: ",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
