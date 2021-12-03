import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/method.dart';
import 'package:sales_officer/BACKEND%20Access/Services/NepaliDateService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SOService.dart';
import 'package:sales_officer/MoreScreen/Settings/SettingsDropDown.dart';

import '../../Database.dart';
import '../../Header.dart';

class SODetail {
  final String title;
  final TextEditingController textEditingController;

  SODetail(this.title, this.textEditingController);
}

class EditSettings extends StatefulWidget {
  final Function refresh;

  EditSettings(this.refresh);

  @override
  State<EditSettings> createState() => _EditSettingsState();
}

class _EditSettingsState extends State<EditSettings> {
  List<String> emptyDetails = [];
  List<SODetail> soDetails = [];
  int maritalStatus = 0;
  List data = [
    [
      Icons.person,
      "Name: ",
      meSO!.SOName,
    ],
    [Icons.email, "Email: ", meSO!.email],
    [Icons.phone, "Phone Number: ", meSO!.phone],
    [Icons.domain_verification, "Reporting Manager: ", meSO!.reportingManager],
    [Icons.location_on_rounded, "Home Location: ", meSO!.homeLocation],
    [Icons.add_business_outlined, "PAN: ", meSO!.PAN],
    [Icons.account_balance, "Bank Account Name: ", meSO!.bankAccountName],
    [
      Icons.account_balance_wallet_sharp,
      "Bank Account Number: ",
      meSO!.bankAccountNumber
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Header(18, false, widget.refresh),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    height: 100,
                    margin: EdgeInsets.only(top: 12, right: 12, left: 12),
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
                              meSO!.email != null
                                  ? Text(
                                      meSO!.email.toString(),
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 15),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                        children: data.map((g) {
                      try {
                        print(g);
                        SODetail soDetail = soDetails.firstWhere((element) {
                          return element.title == g[1];
                        });
                        return Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                            data.indexOf(g) != data.length - 1
                                                ? Colors.black.withOpacity(0.1)
                                                : Colors.transparent))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Icon(
                                          g[0] as IconData,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                g[1] as String,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                data.length > 3
                                    ? Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Center(
                                          child: Container(
                                            child: TextField(
                                              controller:
                                                  soDetail.textEditingController,
                                              cursorWidth: 1,
                                              keyboardType: g[1] ==
                                                      "Phone Number: "
                                                  ? TextInputType.phone
                                                  : g[1] == "PAN: " ||
                                                          g[1] ==
                                                              "Bank Account Number: "
                                                      ? TextInputType.number
                                                      : g[1] == "Email: "
                                                          ? TextInputType
                                                              .emailAddress
                                                          : TextInputType.text,
                                              cursorColor: Colors.blue,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: g[2].toString(),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          emptyDetails.contains(
                                                                  soDetail.title)
                                                              ? Colors.red
                                                              : Colors.grey),
                                                ),
                                                disabledBorder: InputBorder.none,
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: emptyDetails
                                                                .contains(soDetail
                                                                    .title)
                                                            ? Colors.red
                                                            : Colors.grey)),
                                              ),
                                            ),
                                          ),
                                        ),
                                    )
                                    : SettingsDropDown()
                              ],
                            ));
                      } catch (e) {
                        return Container();
                      }
                    }).toList()),
                  ),
                ],
              ),
            ),
            Padding(
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
                      _soApprove();
                      // isEditing = false;
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
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    data.forEach((element) {
      soDetails.add(SODetail(element[1].toString(), TextEditingController()));
    });
    print(soDetails);
    // TODO: implement initState
    super.initState();
  }

  _soApprove() {
    emptyDetails = [];

    setState(() {
      soDetails.forEach((element) {
        if (element.title == "Name: " &&
            element.textEditingController.text.length == 0) {
          emptyDetails.add(element.title);
        }
      });
    });
    if (emptyDetails.length == 0) {
      SOService soService = SOService();
      soService
          .updateSO(
        meSOID!,
        meSO!.ASMID,
        meSO!.districtID,
        meSO!.SOName,
        meSO!.joiningDate,
        homeLocation: soDetails
                    .firstWhere((element) => element.title == "homeLocation")
                    .textEditingController
                    .text ==
                ""
            ? null
            : soDetails
                .firstWhere((element) => element.title == "homeLocation")
                .textEditingController
                .text,
        PAN: soDetails
                    .firstWhere((element) => element.title == "PAN")
                    .textEditingController
                    .text ==
                ""
            ? null
            : int.parse(soDetails
                .firstWhere((element) => element.title == "PAN")
                .textEditingController
                .text),
        phone: soDetails
                    .firstWhere((element) => element.title == "phone")
                    .textEditingController
                    .text ==
                ""
            ? null
            : int.parse(soDetails
                .firstWhere((element) => element.title == "phone")
                .textEditingController
                .text),
        img: "img",
        email: soDetails
                    .firstWhere((element) => element.title == "email")
                    .textEditingController
                    .text ==
                ""
            ? null
            : soDetails
                .firstWhere((element) => element.title == "email")
                .textEditingController
                .text,
        bankAccountName: soDetails
                    .firstWhere((element) => element.title == "bankAccountName")
                    .textEditingController
                    .text ==
                ""
            ? null
            : soDetails
                .firstWhere((element) => element.title == "bankAccountName")
                .textEditingController
                .text,
        bankAccountNumber: soDetails
                    .firstWhere(
                        (element) => element.title == "bankAccountNumber")
                    .textEditingController
                    .text ==
                ""
            ? null
            : soDetails
                .firstWhere((element) => element.title == "bankAccountNumber")
                .textEditingController
                .text,
        bankName: soDetails
                    .firstWhere((element) => element.title == "bankName")
                    .textEditingController
                    .text ==
                ""
            ? null
            : soDetails
                .firstWhere((element) => element.title == "bankName")
                .textEditingController
                .text,
        bankAddress: soDetails
                    .firstWhere((element) => element.title == "bankAddress")
                    .textEditingController
                    .text ==
                ""
            ? null
            : soDetails
                .firstWhere((element) => element.title == "bankAddress")
                .textEditingController
                .text,
        reportingManager: soDetails
                    .firstWhere(
                        (element) => element.title == "reportingManager")
                    .textEditingController
                    .text ==
                ""
            ? null
            : soDetails
                .firstWhere((element) => element.title == "reportingManager")
                .textEditingController
                .text,
        maritalStatus: maritalStatus == 0
            ? null
            : maritalStatus == 1
                ? true
                : false,
        gender: soDetails
                    .firstWhere((element) => element.title == "gender")
                    .textEditingController
                    .text ==
                ""
            ? null
            : soDetails
                .firstWhere((element) => element.title == "gender")
                .textEditingController
                .text,
        DOB: soDetails
                    .firstWhere((element) => element.title == "DOB")
                    .textEditingController
                    .text ==
                ""
            ? null
            : soDetails
                .firstWhere((element) => element.title == "DOB")
                .textEditingController
                .text,
      )
          .then((value) {
        if (value != null) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("The creation was successful")));
          Navigator.pop(context);
          widget.refresh();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("The creation was unsuccessful")));
        }
        soService.fetchSOs().then((value) => allSOLocal = value);
      });
    }
  }
}
