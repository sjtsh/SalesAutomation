import 'package:flutter/cupertino.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/SubGroup.dart';

import '../../Database.dart';

searchForDistributor(String distributor, Function setDistributors) {
  List<Distributor> distributors = [];
  for (int i = 0; i < allDistributorsLocal.length; i++) {
    int numOfCharacters = distributor.length;
    if (numOfCharacters == 0) {
      break;
    }
    try {
      if (distributor.toLowerCase() ==
          allDistributorsLocal[i]
              .distributorName
              .substring(0, numOfCharacters)
              .toLowerCase()) {
        if (!distributors.contains(allDistributorsLocal[i])) {
          distributors.add(allDistributorsLocal[i]);
        }
      }
    } catch (e) {}
    List distributorWords =
        allDistributorsLocal[i].distributorName.toLowerCase().split(" ");
    distributorWords.forEach((element) {
      try {
        if (distributor.toLowerCase() ==
            element.substring(0, numOfCharacters)) {
          if (!distributors.contains(allDistributorsLocal[i])) {
            distributors.add(allDistributorsLocal[i]);
          }
        }
      } catch (e) {}
    });
  }
  setDistributors(distributors);
}

searchForProducts(String product, Function setProducts) {
  List<SubGroup> products = [];
  for (int i = 0; i < allSubGroupsLocal.length; i++) {
    int numOfCharacters = product.length;
    if (numOfCharacters == 0) {
      break;
    }
    try {
      if (product.toLowerCase() ==
          allSubGroupsLocal[i]
              .subGroupName
              .substring(0, numOfCharacters)
              .toLowerCase()) {
        if (!products.contains(allSubGroupsLocal[i])) {
          products.add(allSubGroupsLocal[i]);
        }
      }
    } catch (e) {}
    List productWords = allSubGroupsLocal[i].subGroupName.toLowerCase().split(" ");
    productWords.forEach((element) {
      try {
        if (product.toLowerCase() == element.substring(0, numOfCharacters)) {
          if (!products.contains(allSubGroupsLocal[i])) {
            products.add(allSubGroupsLocal[i]);
          }
        }
      } catch (e) {}
    });
  }
  setProducts(products);
}
