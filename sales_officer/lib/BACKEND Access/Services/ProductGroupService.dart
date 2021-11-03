import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND%20Access/Entities/ProductGroup.dart';


class ProductGroupService {
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getProductGroups";


  Future<List<ProductGroup>> fetchProductGroups() async {
    List<ProductGroup> productGroups=[];
    int aStatusCode = 0;
    while (aStatusCode !=200){

    try{
      final response = await http.get(Uri.parse(url));
      aStatusCode =response.statusCode;
      if (response.statusCode == 200) {
        List<dynamic> values = jsonDecode(response.body);
        List<ProductGroup> productGroups =
            values.map((e) => ProductGroup.fromJson(e)).toList();
        return productGroups;

      } else {
        throw Exception("failed to load post");
      }
    }on SocketException{
      throw Exception("failed to load post");

    }
  } return productGroups;
  }

}
