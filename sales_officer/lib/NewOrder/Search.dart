import 'package:flutter/material.dart';

import '../Database.dart';

searchForDistributor(String distributor, Function setDistributors) {
  List distributors = [];
  for(int i=0; i<allDistributors.length;i++){
    int numOfCharacters = distributor.length;
    if(distributor.toLowerCase() == allDistributors[i].substring(0, numOfCharacters).toLowerCase()){
      distributors.add(allDistributors[i]);
    }
  }
  print(distributors);
  setDistributors(distributors);
}

searchForProducts(String product, Function setProducts){
  List products = [];
  for(int i=0; i<allProducts.length;i++){
    int numOfCharacters = product.length;
    if(product.toLowerCase() == allProducts[i][1].substring(0, numOfCharacters).toLowerCase()){
      print("found " + allProducts[i][1]);
      products.add(allProducts[i]);
    }
  }
  print(products);
  setProducts(products);
}