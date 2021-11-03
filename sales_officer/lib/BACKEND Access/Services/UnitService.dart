import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND%20Access/Entities/Unit.dart';


class UnitService {
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getUnits";

  Future<List<Unit>> fetchUnits() async {
    int aStockStatus = 0;
    while(aStockStatus!= 200){
   try {
      final response = await http.get(Uri.parse(url));
      aStockStatus = response.statusCode;
      if (response.statusCode == 200) {
        List<dynamic> values = jsonDecode(response.body);
        List<Unit> units = values.map((e) => Unit.fromJson(e)).toList();
        return units;
      } else {
        throw Exception("failed to load post");
      }
    }on SocketException{
     throw Exception("failed to load post");
   }on TimeoutException{
     throw Exception("failed to load post");
   }
  }
  throw Exception("Something Went Wrong");
  }

}
