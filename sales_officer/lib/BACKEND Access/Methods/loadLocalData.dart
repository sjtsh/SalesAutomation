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
import 'package:super_tooltip/super_tooltip.dart';

import '../../Database.dart';

bool condition = true;

Future<void> loadLocalData(Function refresh, Function close) async {
  condition = false;
  refresh();
  SubGroupService subGroupService = SubGroupService();
  bool returnable = await subGroupService.fetchSubGroups().then((value) {
    allSubGroupsLocal = value;
    SKUService skuService = SKUService();
    skuService.fetchSKUs().then((value) {
      allSKULocal = value;
      allSKULocal.sort((a, b) => a.subGroupID.compareTo(b.subGroupID));
      SKUDistributorWiseService skuDistributorWiseService =
      SKUDistributorWiseService();
      skuDistributorWiseService.fetchSKUDistributorWises().then((value) {
        allSKUDistributorWiseLocal = value;
      }).then((value) {
        BillingCompanyService billingCompanyService =
        BillingCompanyService();
        billingCompanyService.fetchBillingCompanys().then((value) {
          allBillingCompanysLocal = value;
          UnitService unitService = UnitService();
          unitService.fetchUnits().then((value) {
            allUnitsLocal = value;
            ProductGroupService productGroupService = ProductGroupService();
            productGroupService.fetchProductGroups().then((value) {
              allProductGroupsLocal = value;
              DistrictService districtService = DistrictService();
              districtService.fetchDistricts().then((value) {
                allDistrictsLocal = value;
                FamiliarityService familiarityService =
                FamiliarityService();
                familiarityService.fetchFamiliaritys().then((value) {
                  allFamiliaritysLocal = value;
                  DistributorService distributorService =
                  DistributorService();
                  distributorService.fetchDistributors().then((value) {
                    allDistributorsLocal = value;
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
                        condition = true;
                        refresh();
                        close();
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
