import 'package:flutter/material.dart';
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
import 'package:sales_officer/LogInScreen/LogInScreen.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../Database.dart';

bool condition = true;

void loadLocalData(Function refresh, Function close, context) {
  condition = false;
  refresh();
  SubGroupService subGroupService = SubGroupService();
  subGroupService.fetchSubGroups(context).then((value) {
    allSubGroupsLocal = value.where((element) => !element.deactivated).toList();
    SKUService skuService = SKUService();
    skuService.fetchSKUs().then((value) {
      allSKULocal = value.where((element) => !element.deactivated).toList();
      allSKULocal.sort((a, b) => a.subGroupID.compareTo(b.subGroupID));
      SKUDistributorWiseService skuDistributorWiseService =
          SKUDistributorWiseService();
      skuDistributorWiseService.fetchSKUDistributorWises().then((value) {
        allSKUDistributorWiseLocal = value;
      }).then((value) {
        BillingCompanyService billingCompanyService = BillingCompanyService();
        billingCompanyService.fetchBillingCompanys(context).then((value) {
          allBillingCompanysLocal = value.where((element) => !element.deactivated).toList();
          UnitService unitService = UnitService();
          unitService.fetchUnits().then((value) {
            allUnitsLocal = value;
            ProductGroupService productGroupService = ProductGroupService();
            productGroupService.fetchProductGroups().then((value) {
              allProductGroupsLocal = value.where((element) => !element.deactivated).toList();
              DistrictService districtService = DistrictService();
              districtService.fetchDistricts(context).then((value) {
                allDistrictsLocal = value.where((element) => !element.deactivated).toList();
                FamiliarityService familiarityService = FamiliarityService();
                familiarityService.fetchFamiliaritys(context).then((value) {
                  allFamiliaritysLocal = value.where((element) => !element.deactivated).toList();
                  DistributorService distributorService = DistributorService();
                  distributorService.fetchDistributors().then((value) {
                    allDistributorsLocal = value.where((element) => !element.deactivated).toList();
                    SOService soService = SOService();
                    soService.fetchSOs().then((value) {
                      try {
                        meSO = value
                            .firstWhere((element) => element.SOID == meSOID);
                      } catch (e) {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => LogInScreen()));
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
                                element1.distributorID ==
                                    element.distributorID) {
                              condition = true;
                            }
                          });
                          return condition;
                        }).toList();
                        condition = true;
                        refresh();
                        close();
                        personalDistributorsLocal.forEach((element) {

                        });
                        return true;
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
    return false;
  });
}
