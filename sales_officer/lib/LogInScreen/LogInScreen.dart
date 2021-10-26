import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorSale.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/calculateSales.dart';
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
      subGroupService.fetchSubGroups().then((value) {
        allSubGroupsLocal = value;
        setState(() {
          loadingText = "Getting SKUs";
        });
        SKUService skuService = SKUService();
        skuService.fetchSKUs().then((value) {
          allSKULocal = value;
          allSKULocal.sort((a, b) => a.subGroupID.compareTo(b.subGroupID));
          setState(() {
            loadingText = "Getting SKU Distributor Wise";
          });
          SKUDistributorWiseService skuDistributorWiseService =
              SKUDistributorWiseService();
          skuDistributorWiseService.fetchSKUDistributorWises().then((value) {
            allSKUDistributorWiseLocal = value;
            setState(() {
              loadingText = "Getting Billing Companies";
            });
          }).then((value) {
            BillingCompanyService billingCompanyService =
                BillingCompanyService();
            billingCompanyService.fetchBillingCompanys().then((value) {
              allBillingCompanysLocal = value;
              setState(() {
                loadingText = "Loading Units";
              });
              UnitService unitService = UnitService();
              unitService.fetchUnits().then((value) {
                allUnitsLocal = value;
                setState(() {
                  loadingText = "Loading Product Lines";
                });
                ProductGroupService productGroupService = ProductGroupService();
                productGroupService.fetchProductGroups().then((value) {
                  allProductGroupsLocal = value;
                  setState(() {
                    loadingText = "Loading Districts";
                  });
                  DistrictService districtService = DistrictService();
                  districtService.fetchDistricts().then((value) {
                    allDistrictsLocal = value;
                    setState(() {
                      loadingText = "Loading Familiarities";
                    });
                    FamiliarityService familiarityService =
                        FamiliarityService();
                    familiarityService.fetchFamiliaritys().then((value) {
                      allFamiliaritysLocal = value;
                      setState(() {
                        loadingText = "Loading Distributors";
                      });
                      DistributorService distributorService =
                          DistributorService();
                      distributorService.fetchDistributors().then((value) {
                        allDistributorsLocal = value;
                        setState(() {
                          loadingText = "Almost Done";
                        });
                        SOService soService = SOService();
                        soService.fetchSOs().then((value) {
                          meSO = value
                              .firstWhere((element) => element.SOID == meSOID);
                          SODistributorConnectionService
                              soDistributorConnectionService =
                              SODistributorConnectionService();
                          soDistributorConnectionService
                              .fetchSODistributorConnections()
                              .then((newValue) {
                            allSODistributorConnectionsLocal = newValue;
                            personalDistributorsLocal =
                                allDistributorsLocal.where((element) {
                              bool condition = false;
                              allSODistributorConnectionsLocal
                                  .forEach((element1) {
                                if (element1.SOID == meSO?.SOID &&
                                    element1.distributorID ==
                                        element.distributorID) {
                                  condition = true;
                                }
                              });
                              return condition;
                            }).toList();
                            setState(() {
                              loadingText = "Calculating Sales";
                            });
                            // calculateSales();
                            setState(() {
                              isLoaded = true;
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
                        color: Colors.red,
                        backgroundColor: Colors.red.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(loadingText),
                  ],
                ),
              ),
            ),
          );
  }
}
