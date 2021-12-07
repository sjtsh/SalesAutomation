import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorService.dart';
import 'package:sales_officer/BreadCrum/BreadCrum.dart';
import 'package:sales_officer/MoreScreen/Settings/SettingsDropDown.dart';

import '../Database.dart';
import '../Header.dart';

class DistributorDetail {
  final String title;
  final TextEditingController textEditingController;


  DistributorDetail(this.title, this.textEditingController);
}

class MoreFieldScreen extends StatefulWidget {
  final Distributor currentDistributor;
  final Function refresh;

  MoreFieldScreen(this.currentDistributor, this.refresh);

  @override
  _MoreFieldScreenState createState() => _MoreFieldScreenState();
}

class _MoreFieldScreenState extends State<MoreFieldScreen> {
  List<String> emptyDetails = [];
  List<DistributorDetail> distributorDetails = [];
  int maritalStatus = 0;

  List data = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Header(18, false, widget.refresh),
            Container(
              padding: EdgeInsets.only(left: 12),
              alignment: Alignment.centerLeft,
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.black.withOpacity(0.1),
                  ),
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: BreadCrum3(
                "Distributor",
                widget.currentDistributor.distributorName,
                "Edit Details",
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                        DistributorDetail distributorDetail =
                            distributorDetails.firstWhere((element) {
                          return element.title == g[0];
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
                                      // Padding(
                                      //   padding:
                                      //       const EdgeInsets.only(top: 20.0),
                                      //   child: Icon(
                                      //     g[0] as IconData,
                                      //     color: Colors.blueGrey,
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   width: 12,
                                      // ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                g[0] as String,
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
                                        padding: const EdgeInsets.all(12),
                                        child: Center(
                                          child: Container(
                                            child: TextField(

                                              controller: distributorDetail
                                                  .textEditingController,



                                              cursorWidth: 1,
                                              keyboardType: g[0] ==
                                                      "Phone Number: "
                                                  ? TextInputType.phone
                                                  : g[0] == "PAN: " ||
                                                          g[0] ==
                                                              "Bank Account Number: "
                                                      ? TextInputType.number
                                                      : g[0] == "Email: "
                                                          ? TextInputType
                                                              .emailAddress
                                                          : TextInputType.text,
                                              cursorColor: Colors.blue,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                              decoration: InputDecoration(
                                                // hintText: g[1].toString(),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: emptyDetails.contains(
                                                              distributorDetail
                                                                  .title)
                                                          ? Colors.red
                                                          : Colors.grey),
                                                ),
                                                disabledBorder:
                                                    InputBorder.none,
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: emptyDetails
                                                                .contains(
                                                                    distributorDetail
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
                      _distributorApprove();
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

    data = [
      ["Name: ", widget.currentDistributor.distributorName],
      ["Distributor Type: ", widget.currentDistributor.distributorType],
      ["Owner Name: ", widget.currentDistributor.ownerName],
      ["Phone Number: ", widget.currentDistributor.phone],
      ["Mobile Number: ", widget.currentDistributor.mobileNumber],
      ["Email: ", widget.currentDistributor.email],
      ["PAN: ", widget.currentDistributor.PAN],
      ["Address: ", widget.currentDistributor.location],
      ["Bank Account Name: ", widget.currentDistributor.bankAccountName],
      ["Bank Account Number: ", widget.currentDistributor.bankAccountNumber],
      ["Bank Name: ",widget.currentDistributor.bankName],
      ["Bank Address: ", widget.currentDistributor.bankAddress],
      ["VAT Number: ", widget.currentDistributor.VAT],
      ["Latitude: ", widget.currentDistributor.lat],
      ["Longitude: ", widget.currentDistributor.lng],
    ];

    data.forEach((element) {
      distributorDetails.add(
          DistributorDetail(element[0].toString(), TextEditingController(text: element[1].toString())));
    });
    print(distributorDetails);
    // TODO: implement initState
    super.initState();
  }

  _distributorApprove() {
    emptyDetails = [];

    setState(() {
      distributorDetails.forEach((element) {
        if (element.title == "Name: " &&
            element.textEditingController.text.length == 0) {
          emptyDetails.add(element.title);
        }
        if (element.title == "Distributor Type: " &&
            element.textEditingController.text.length == 0) {
          emptyDetails.add(element.title);
        }
      });
    });
    if (emptyDetails.length == 0) {
      DistributorService distributorService = DistributorService();
      distributorService
          .updateDistributor(
        widget.currentDistributor.distributorID,
        distributorDetails
            .firstWhere((element) => element.title == "Name: ")
            .textEditingController
            .text,
        distributorDetails
            .firstWhere((element) => element.title == "Distributor Type: ")
            .textEditingController
            .text,
        widget.currentDistributor.townID,
        email: distributorDetails
                    .firstWhere((element) => element.title == "Email: ")
                    .textEditingController
                    .text ==
                ""
            ? null
            : distributorDetails
                .firstWhere((element) => element.title == "Email: ")
                .textEditingController
                .text,
        mobileNumber: distributorDetails
                    .firstWhere((element) => element.title == "Mobile Number: ")
                    .textEditingController
                    .text ==
                ""
            ? null
            : int.parse(distributorDetails
                .firstWhere((element) => element.title == "Mobile Number: ")
                .textEditingController
                .text),
        phone: distributorDetails
                    .firstWhere((element) => element.title == "Phone Number: ")
                    .textEditingController
                    .text ==
                ""
            ? null
            : int.parse(distributorDetails
                .firstWhere((element) => element.title == "Phone Number: ")
                .textEditingController
                .text),
        ownerName: distributorDetails
                    .firstWhere((element) => element.title == "Owner Name: ")
                    .textEditingController
                    .text==""

            ? null
            : distributorDetails
                .firstWhere((element) => element.title == "Owner Name: ")
                .textEditingController
                .text,
        PAN: distributorDetails
                    .firstWhere((element) => element.title == "PAN: ")
                    .textEditingController
                    .text ==
                ""
            ? null
            : int.parse(distributorDetails
                .firstWhere((element) => element.title == "PAN: ")
                .textEditingController
                .text),
        bankName: distributorDetails
                    .firstWhere((element) => element.title == "Bank Name: ")
                    .textEditingController
                    .text ==
                ""
            ? null
            : distributorDetails
                .firstWhere((element) => element.title == "Bank Name: ")
                .textEditingController
                .text,
        bankAddress: distributorDetails
                    .firstWhere((element) => element.title == "Bank Address: ")
                    .textEditingController
                    .text ==
                ""
            ? null
            : distributorDetails
                .firstWhere((element) => element.title == "Bank Address: ")
                .textEditingController
                .text,
        bankAccountName: distributorDetails
                    .firstWhere((element) => element.title == "Bank Account Name: ")
                    .textEditingController
                    .text ==
                ""
            ? null
            : distributorDetails
                .firstWhere((element) => element.title == "Bank Account Name: ")
                .textEditingController
                .text,
        bankAccountNumber: distributorDetails
                    .firstWhere(
                        (element) => element.title == "Bank Account Number: ")
                    .textEditingController
                    .text ==
                ""
            ? null
            : distributorDetails
                .firstWhere((element) => element.title == "Bank Account Number: ")
                .textEditingController
                .text,
        location: distributorDetails
                    .firstWhere((element) => element.title == "Address: ")
                    .textEditingController
                    .text ==
                ""
            ? null
            : distributorDetails
                .firstWhere((element) => element.title == "Address: ")
                .textEditingController
                .text,
        img: "img",
        VAT: distributorDetails
                    .firstWhere((element) => element.title == "VAT Number: ")
                    .textEditingController
                    .text ==
                ""
            ? null
            : int.parse(distributorDetails
                .firstWhere((element) => element.title == "VAT Number: ")
                .textEditingController
                .text),
        lat: distributorDetails
                    .firstWhere((element) => element.title == "Latitude: ")
                    .textEditingController
                    .text ==
                ""
            ? null
            : double.parse(distributorDetails
                .firstWhere((element) => element.title == "Latitude: ")
                .textEditingController
                .text),
        lng: distributorDetails
                    .firstWhere((element) => element.title == "Longitude: ")
                    .textEditingController
                    .text ==
                ""
            ? null
            : double.parse(distributorDetails
                .firstWhere((element) => element.title == "Longitude: ")
                .textEditingController
                .text),
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
        distributorService
            .fetchDistributors()
            .then((value) => allDistributorsLocal = value);
      });
    }
  }
}
