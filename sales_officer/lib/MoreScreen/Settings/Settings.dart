import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/SO.dart';
import 'package:sales_officer/BACKEND/Methods/method.dart';
import 'package:sales_officer/Database.dart';

import '../../Header.dart';
import 'EditSettings.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Header(9, false),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    height: 100,
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                    child: Row(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: ShapeDecoration(
                            color: Colors.green,
                            shape: CircleBorder(),
                          ),
                          child: Center(
                            child: Text(
                              getInitials(meSO!.SOName),
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                meSO!.SOName,
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                meSO!.email,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Material(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isEditing = true;
                                });
                              },
                              child: isEditing
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.edit,
                                        size: 30,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      [
                        [
                          Icons.person,
                          "Name: ",
                          meSO!.SOName,
                        ],
                        [Icons.email, "Email: ", meSO!.email],
                        [Icons.phone, "Phone Number: ", meSO!.phone],
                        [
                          Icons.domain_verification,
                          "Reporting Manager: ",
                          meSO!.reportingManager
                        ],
                        [
                          Icons.location_on_rounded,
                          "Home Location: ",
                          meSO!.homeLocation
                        ],
                        [Icons.add_business_outlined, "PAN: ", meSO!.PAN],
                        [
                          Icons.my_location_outlined,
                          "District Name: ",
                          meSO!.districtName,
                        ],
                        [
                          Icons.account_balance,
                          "Bank Account Name: ",
                          meSO!.bankAccountName
                        ],
                        [
                          Icons.account_balance_wallet_sharp,
                          "Bank Account Number: ",
                          meSO!.bankAccountNumber
                        ],
                      ],
                      [
                        [
                          Icons.notifications_active_outlined,
                          "Approved Order Notifications: ",
                          "yes"
                        ],
                        [
                          Icons.notifications_paused_outlined,
                          "Holiday Notifications: ",
                          "yes"
                        ],
                        [
                          Icons.notification_important_outlined,
                          "Goal Notifications: ",
                          "yes"
                        ]
                      ]
                    ].asMap().entries
                        .map(
                          (e) => isEditing
                              ? EditSettings(e.value)
                              : Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
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
                                  child: Column(
                                    children: e.value
                                        .map(
                                          (f) => Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: e.key !=
                                                                e.value.length - 1
                                                            ? Colors.black
                                                                .withOpacity(
                                                                    0.1)
                                                            : Colors
                                                                .transparent))),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 12,
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    f[0] as IconData,
                                                    color: Colors.blueGrey,
                                                  ),
                                                  SizedBox(
                                                    width: 12,
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 20.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            f[1] as String,
                                                          ),
                                                          Expanded(
                                                              child:
                                                                  Container()),
                                                          Text(
                                                            f[2].toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            isEditing
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffF2B200),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            isEditing = false;
                          });
                        },
                        child: Center(
                          child: Text(
                            "Request for Approval",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
