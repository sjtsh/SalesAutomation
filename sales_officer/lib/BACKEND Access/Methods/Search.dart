import 'package:flutter/cupertino.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SubGroup.dart';

import '../../Database.dart';

searchForDistributor(String distributor, Function setDistributors) {
  List<Distributor> distributors = [];
  for (int i = 0; i < personalDistributorsLocal.length; i++) {
    int numOfCharacters = distributor.length;
    if (numOfCharacters == 0) {
      break;
    }
    try {
      if(personalDistributorsLocal[i]
          .distributorName != "null"){
        if (distributor.toLowerCase() ==
            personalDistributorsLocal[i]
                .distributorName
                .substring(0, numOfCharacters)
                .toLowerCase()) {
          if (!distributors.contains(personalDistributorsLocal[i])) {
            distributors.add(personalDistributorsLocal[i]);
          }
        }
      }
    } catch (e) {
      throw Exception("Unable to change to lower case");
    }
    if(   personalDistributorsLocal[i]
        .distributorName!="null"){
      List distributorWords =
          personalDistributorsLocal[i].distributorName.toLowerCase().split(" ");
      distributorWords.forEach((element) {
        try {
          if (distributor.toLowerCase() ==
              element.substring(0, numOfCharacters)) {
            if (!distributors.contains(personalDistributorsLocal[i])) {
              distributors.add(personalDistributorsLocal[i]);
            }
          }
        } catch (e) {
          throw Exception("Unable to change to lower case");
        }
      });
    }
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
     if(allSubGroupsLocal[i]
         .subGroupName!="null") {
        if (product.toLowerCase() ==
            allSubGroupsLocal[i]
                .subGroupName
                .substring(0, numOfCharacters)
                .toLowerCase()) {
          if (!products.contains(allSubGroupsLocal[i])) {
            products.add(allSubGroupsLocal[i]);
          }
        }
      }
    } catch (e) {}
    if (allSubGroupsLocal[i].subGroupName != "null") {
      List productWords =
          allSubGroupsLocal[i].subGroupName.toLowerCase().split(" ");
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
  }
  setProducts(products);
}
