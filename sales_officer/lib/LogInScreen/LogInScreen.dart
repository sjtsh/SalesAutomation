import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorSale.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/calculateSales.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/calculateWeeklySales.dart';
import 'package:sales_officer/BACKEND%20Access/Services/BillingCompanyService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistrictService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/FamiliarityService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/ProductGroupService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SKUDistributorWiseService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SKUService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SODistributorConnectionService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SOService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SubGroupService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/UnitService.dart';

import '../Database.dart';
import '../HomeScreen.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool isSelected = false;
  int percentage = 0;

  select() {
    setState(() {
      isSelected = true;
    });
  }

  bool isLoaded = false;

  String loadingText = "Getting SubGroups...";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (allDistributorsLocal.length == 0 || allSubGroupsLocal.length == 0) {
      SubGroupService subGroupService = SubGroupService();
      subGroupService.fetchSubGroups(context).then((value) {
        allSubGroupsLocal = value;

        setState(() {
          loadingText = "Loading SKUs";
          percentage = 10;
        });
        SKUService skuService = SKUService();
        skuService.fetchSKUs().then((value) {
          allSKULocal = value;
          allSKULocal.sort((a, b) => a.subGroupID.compareTo(b.subGroupID));
          setState(() {
            loadingText = "Loading SKU Distributor Wise";
            percentage = 20;
          });
          DistributorService distributorService = DistributorService();
          distributorService.fetchDistributors().then((value) {
            allDistributorsLocal = value;
            setState(() {
                loadingText = "Loading Profile";
              percentage = 30;
            });
            SOService soService = SOService();
            soService.fetchSOs().then((value) {
              try {
                meSO = value.firstWhere((element) => element.SOID == meSOID);
              } catch (e) {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return LogInScreen();
                }));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("NO SOID FOUND"),
                  ),
                );
              }
              SODistributorConnectionService soDistributorConnectionService =
                  SODistributorConnectionService();
              soDistributorConnectionService
                  .fetchSODistributorConnections()
                  .then((newValue) {
                allSODistributorConnectionsLocal = newValue;
                personalDistributorsLocal =
                    allDistributorsLocal.where((element) {
                  bool condition = false;
                  allSODistributorConnectionsLocal.forEach((element1) {
                    if (element1.SOID == meSO?.SOID &&
                        element1.distributorID == element.distributorID) {
                      condition = true;
                    }
                  });
                  return condition;
                }).toList();
                setState(() {
                  loadingText = "Calculating Sales";
                  percentage = 40;
                });
                calculateWeeklySales(context);
                calculateSales(setLoaded, context);
                SKUDistributorWiseService skuDistributorWiseService =
                    SKUDistributorWiseService();
                skuDistributorWiseService
                    .fetchSKUDistributorWises()
                    .then((value) {
                  allSKUDistributorWiseLocal = value;
                  setState(() {
                    loadingText = "Loading Billing Companies";
                    percentage = 50;
                  });
                }).then((value) {
                  BillingCompanyService billingCompanyService =
                      BillingCompanyService();
                  billingCompanyService
                      .fetchBillingCompanys(context)
                      .then((value) {
                    allBillingCompanysLocal = value;
                    setState(() {
                      loadingText = "Loading Units";
                      percentage = 60;
                    });
                    UnitService unitService = UnitService();
                    unitService.fetchUnits().then((value) {
                      allUnitsLocal = value;
                      setState(() {
                        loadingText = "Loading Product Groups";
                        percentage = 70;
                      });
                      ProductGroupService productGroupService =
                          ProductGroupService();
                      productGroupService.fetchProductGroups().then((value) {
                        allProductGroupsLocal = value;
                        setState(() {
                          loadingText = "Loading Districts";
                          percentage = 80;
                        });
                        DistrictService districtService = DistrictService();
                        districtService.fetchDistricts(context).then((value) {
                          allDistrictsLocal = value;
                          setState(() {
                            loadingText = "Loading Familiarities";
                            percentage = 90;
                          });
                          FamiliarityService familiarityService =
                              FamiliarityService();
                          familiarityService
                              .fetchFamiliaritys(context)
                              .then((value) {
                            allFamiliaritysLocal = value;
                            setState(() {
                              loadingText = "Loading Distributors";
                              percentage = 100;
                            });
                          });
                        });
                      });
                    });
                  });
                });
              });
            });
          });
        });
      });
    } else {
      isLoaded = true;
    }
  }

  setLoaded() {
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ?
        //     ? SafeArea(
        //   child: Scaffold(
        //     backgroundColor: Color(0xffF5F5F5),
        //     body: Column(
        //       children: [
        //         Container(
        //           margin: EdgeInsets.all(12),
        //           alignment: Alignment.centerLeft,
        //           child: InkWell(
        //             onTap: () {
        //               Navigator.pop(context);
        //             },
        //             child: Icon(
        //               Icons.arrow_back,
        //             ),
        //           ),
        //         ),
        //         Expanded(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Center(
        //                 child: Container(
        //                   height: 130,
        //                   width: 100,
        //                   decoration: BoxDecoration(
        //                     shape: BoxShape.circle,
        //                     color: Colors.green,
        //                   ),
        //                   child: Center(
        //                     child: Text(
        //                       getInitials(meSO!.SOName),
        //                       style: TextStyle(
        //                           color: Colors.white, fontSize: 30),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //               SizedBox(
        //                 height: 10,
        //               ),
        //               Text(
        //                 meSO!.SOName,
        //                 style: TextStyle(
        //                     fontWeight: FontWeight.bold, fontSize: 18),
        //               ),
        //               SizedBox(
        //                 height: 5,
        //               ),
        //               Text(
        //                 "Sales Officer",
        //                 style: TextStyle(color: Colors.grey, fontSize: 18),
        //               ),
        //             ],
        //           ),
        //         ),
        //         Column(
        //           children: [
        //             isSelected
        //                 ? Text(
        //               "Please select your today's beat",
        //               style: TextStyle(fontSize: 18),
        //             )
        //                 : Container(),
        //             Padding(
        //               padding: const EdgeInsets.all(18.0),
        //               child: AnimatedContainer(
        //                 duration: Duration(milliseconds: 500),
        //                 clipBehavior: Clip.hardEdge,
        //                 height: isSelected ? 60 * 6 : null,
        //                 decoration: BoxDecoration(
        //                   color: Colors.white,
        //                   borderRadius: BorderRadius.circular(12),
        //                   boxShadow: [
        //                     BoxShadow(
        //                       color: Colors.grey.withOpacity(0.5),
        //                       offset: Offset(0, 2),
        //                       blurRadius: 3,
        //                     ),
        //                   ],
        //                 ),
        //                 child:
        //                 isSelected ? SelectBeat() : JointWorking(select),
        //               ),
        //             )
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // )
        HomeScreen()
        : SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("icons/logo.svg"),
                    SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        value: percentage / 100,
                        color: Colors.red,
                        backgroundColor: Colors.red.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("$loadingText....($percentage%)"),
                      ],
                    ),
                    // Text("($percentage%)")
                  ],
                ),
              ),
            ),
          );
  }
}
