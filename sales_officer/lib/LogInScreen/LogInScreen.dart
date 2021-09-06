import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_officer/BACKEND/Entities/SKUStock.dart';
import 'package:sales_officer/BACKEND/Services/DistributorService.dart';
import 'package:sales_officer/BACKEND/Services/SKUDistributorWiseService.dart';
import 'package:sales_officer/BACKEND/Services/SKUService.dart';
import 'package:sales_officer/BACKEND/Services/SubGroupService.dart';
import 'package:sales_officer/LogInScreen/JointWorking.dart';
import 'package:sales_officer/LogInScreen/SelectBeat.dart';
import 'package:sales_officer/SignIn/SignInButton.dart';

import '../Database.dart';

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

  String loadingText = "Getting Distributors...";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DistributorService distributorService = DistributorService();
    distributorService.fetchDistributors().then((value) {
      allDistributorsLocal = value;
      setState(() {
        loadingText = "Getting SubGroups";
      });
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
              loadingText = "Almost Done";
              isLoaded = true;
            });
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? Scaffold(
            backgroundColor: Color(0xffF5F5F5),
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(12),
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          height: 130,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/face.png"),
                            ),
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "John Doe",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Sales Officer",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    isSelected
                        ? Text(
                            "Please select your today's beat",
                            style: TextStyle(fontSize: 18),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        clipBehavior: Clip.hardEdge,
                        height: isSelected ? 60 * 6 : null,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(0, 2),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: isSelected ? SelectBeat() : JointWorking(select),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        : LoadingScreen(loadingText);
  }
}
