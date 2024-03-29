import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorSale.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SO.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/calculateSales.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/calculateWeeklySales.dart';
import 'package:sales_officer/BACKEND%20Access/Services/BillingCompanyService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistrictService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/FamiliarityService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/NepaliDateService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/ProductGroupService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SKUDistributorWiseService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SKUService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SODistributorConnectionService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SOService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SubGroupService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/TaskService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/UnitService.dart';
import 'package:sales_officer/DidnotEndDay.dart';
import 'package:sales_officer/MoreScreen/ActivitiesScreen/ActivitiesScreen.dart';
import 'package:sales_officer/Profile/SliderPersonal.dart';
import 'package:sales_officer/foreground/foreground.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Database.dart';
import '../HomeScreen.dart';
import '../timer.dart';

class LogInScreen extends StatefulWidget {
  @override
  LogInScreenState createState() => LogInScreenState();
}

class LogInScreenState extends State<LogInScreen> {
  bool isSelected = false;
  int percentage = 0;
  static StopWatchPersonal watch = StopWatchPersonal();

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

    NepaliDateService().fetchNepaliDate().then((date) {
      SharedPreferences.getInstance().then((value) {
        if ((value.getString("logInDateTime") ?? "0000-00-00 00:00:00")
                .substring(0, 10) !=
            date.substring(0, 10)) {
          if (DateTime.parse(
                  (value.getString("logInDateTime") ?? "0000-00-00 00:00:00"))
              .isAfter(DateTime.parse((value.getString("logOutDateTime") ??
                  "0000-00-00 00:00:00")))) {
            print("the day ended without a logout");
            didnotEndDay = true;
          }
          value.setBool("isRetailing", false);
          isRetailing = false;
          LogInScreenState.watch.milliseconds = 0;
          elapsedTime =
              transformMilliSeconds(LogInScreenState.watch.elapsedMillis);
        } else {
          soLogInDetailID = value.getInt("soLogInDetailID") ?? 0;
          isRetailing = value.getBool("isRetailing") ?? false;
          if (isRetailing!) {
            LogInScreenState.watch.milliseconds = DateTime.parse(date)
                .difference(
                    DateTime.parse(value.getString("logInDateTime") ?? date))
                .inMilliseconds;
            LogInScreenState.watch.milliseconds =
                LogInScreenState.watch.elapsedMillis +
                        value.getInt("retailingTime") ??
                    0;
            elapsedTime =
                transformMilliSeconds(LogInScreenState.watch.elapsedMillis);
          } else {
            LogInScreenState.watch.milliseconds =
                value.getInt("retailingTime") ?? 0;
            elapsedTime =
                transformMilliSeconds(LogInScreenState.watch.elapsedMillis);
          }
        }

        // if (value.getBool("isRetailing") ?? false) {
        //   initForegroundTask().then((value) {
        //     FlutterForegroundTask.isRunningService.then((value) {
        //       startForegroundTask();
        //     });
        //   });
        // }
      }).then((value) {
        SubGroupService subGroupService = SubGroupService();
        subGroupService.fetchSubGroups(context).then((value) {
          allSubGroupsLocal = value;

          setState(() {
            loadingText = "Loading SKUs...";
            percentage = 10;
          });
          TaskService taskService = TaskService();
          taskService.fetchTasks().then((value) {
            allTaskLocal = value;
            SKUService skuService = SKUService();
            skuService.fetchSKUs().then((value) {
              allSKULocal = value;
              allSKULocal.sort((a, b) => a.subGroupID.compareTo(b.subGroupID));
              setState(() {
                loadingText = "Loading Distributors...";
                percentage = 20;
              });
              DistributorService distributorService = DistributorService();
              distributorService.fetchDistributors().then((value) {
                allDistributorsLocal = value;
                setState(() {
                  loadingText = "Loading Profile...";
                  percentage = 30;
                });
                SOService soService = SOService();
                soService.fetchSOs().then((value) {
                  allSOLocal = value;
                  try {
                    SO aSO =
                        value.firstWhere((element) => element.SOID == meSOID);
                    if (aSO.deactivated) {
                      SharedPreferences.getInstance()
                          .then((prefs) => prefs.setInt("meSOID", 0));
                    } else {
                      meSO = aSO;
                    }
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
                      allSODistributorConnectionsLocal.forEach((element1) {
                        if (element1.SOID == meSO?.SOID &&
                            element1.distributorID == element.distributorID) {
                          condition = true;
                        }
                      });
                      return condition;
                    }).toList();
                    setState(() {
                      loadingText = "Calculating Sales...";
                      percentage = 40;
                    });
                    calculateWeeklySales(context);
                    calculateSales(context);
                    SKUDistributorWiseService skuDistributorWiseService =
                        SKUDistributorWiseService();
                    skuDistributorWiseService
                        .fetchSKUDistributorWises()
                        .then((value) {
                      allSKUDistributorWiseLocal = value;
                      setState(() {
                        loadingText = "Loading Billing Companies...";
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
                          loadingText = "Loading Units...";
                          percentage = 60;
                        });
                        UnitService unitService = UnitService();
                        unitService.fetchUnits().then((value) {
                          allUnitsLocal = value;
                          setState(() {
                            loadingText = "Loading Product Groups...";
                            percentage = 70;
                          });
                          ProductGroupService productGroupService =
                              ProductGroupService();
                          productGroupService
                              .fetchProductGroups()
                              .then((value) {
                            allProductGroupsLocal = value;
                            setState(() {
                              loadingText = "Loading Districts...";
                              percentage = 80;
                            });
                            DistrictService districtService = DistrictService();
                            districtService
                                .fetchDistricts(context)
                                .then((value) {
                              allDistrictsLocal = value;
                              setState(() {
                                loadingText = "Almost Done...";
                                percentage = 90;
                              });
                              FamiliarityService familiarityService =
                                  FamiliarityService();
                              familiarityService
                                  .fetchFamiliaritys(context)
                                  .then((value) {
                                allFamiliaritysLocal = value;
                                setState(() {
                                  loadingText = "Thank You for your patience";
                                  percentage = 100;
                                  SharedPreferences.getInstance().then((prefs) {
                                    isNotificationClicked = prefs
                                            .getBool("isNotificationClicked") ??
                                        false;
                                    isLoaded = true;
                                    prefs.setBool(
                                        "isNotificationClicked", true);
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
          });
        });
      });
    });
  }

  setLoaded() {
    setState(() {
      isLoaded = true;
    });
  }

  setEndDay() {
    setState(() {
      didnotEndDay = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? didnotEndDay
            ? DidnotEndDay(setEndDay)
            : HomeScreen()
        : SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Container()),
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
                        Text("$loadingText($percentage%)"),
                      ],
                    ),
                    // Text("($percentage%)")
                    Expanded(child: Container()),
                    Text(
                      "Version 0.0.0.2",
                      style: TextStyle(color: Colors.red.withOpacity(0.5)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
