import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/SubGroup.dart';
import 'package:sales_officer/BACKEND/Services/DistributorService.dart';

import 'Database.dart';

searchForDistributor(String distributor, Function setDistributors) {
  List<Distributor> distributors = [];
  for(int i=0; i<allDistributorsLocal.length;i++){
    int numOfCharacters = distributor.length;
    if(distributor.toLowerCase() == allDistributorsLocal[i].distributorName.substring(0, numOfCharacters).toLowerCase()){
      distributors.add(allDistributorsLocal[i]);
    }
  }
  setDistributors(distributors);
}

searchForProducts(String product, Function setProducts){
  List<SubGroup> products = [];
  for(int i=0; i<allSubGroupsLocal.length;i++){
    int numOfCharacters = product.length;
    if(product.toLowerCase() == allSubGroupsLocal[i].subGroupName.substring(0, numOfCharacters).toLowerCase()){
      products.add(allSubGroupsLocal[i]);
    }
  }
  setProducts(products);
}