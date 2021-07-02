import 'package:flutter/material.dart';

import '../Database.dart';

searchDistributor(String distributor, Function setDistributors) {
  List distributors = [];
  // for (int i = 0; i < allDistributors.length; i++) {
  //   if (distributor.toLowerCase() == allDistributors[i].toLowerCase()) {
  //     distributors.add(allDistributors[i]);
  //   } else if (distributor.length == 0) {
  //     distributors.addAll(allDistributors);
  //     break;
  //   } else if (distributor.length == 1) {
  //     if (distributor.toLowerCase() ==
  //         allDistributors[i].substring(0, 1).toLowerCase()) {
  //       distributors.add(allDistributors[i]);
  //     }
  //   } else if (distributor.length == 2) {
  //     if (distributor.toLowerCase() ==
  //         allDistributors[i].substring(0, 2).toLowerCase()) {
  //       distributors.add(allDistributors[i]);
  //     }
  //   } else if (distributor.length == 3) {
  //     if (distributor.toLowerCase() ==
  //         allDistributors[i].substring(0, 3).toLowerCase()) {
  //       distributors.add(allDistributors[i]);
  //     }
  //   } else {
  //     if (distributor.length == 4) {
  //       if (distributor.toLowerCase() ==
  //           allDistributors[i].substring(0, 4).toLowerCase()) {
  //         distributors.add(allDistributors[i]);
  //       }
  //     }
  //   }
  // }
  for(int i=0; i<allDistributors.length;i++){
    int numOfCharacters = distributor.length;
    if(distributor.toLowerCase() == allDistributors[i].substring(0, numOfCharacters).toLowerCase()){
      distributors.add(allDistributors[i]);
    }
  }
  print(distributors);
  setDistributors(distributors);
}
