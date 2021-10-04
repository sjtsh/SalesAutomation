import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND/Entities/SKUStock.dart';

class SKUStockService {
  Future<List<SKUStock>> fetchSKUStocks() async {
    final response = await http.get(Uri.parse(
        "https://asia-south1-hilifedb.cloudfunctions.net/getSKUStocks"));
    if (response.statusCode == 200) {
      List<dynamic> values = jsonDecode(response.body);
      List<SKUStock> SKUStocks =
          values.map((e) => SKUStock.fromJson(e)).toList();
      return SKUStocks;
    } else {
      throw Exception("failed to load post");
    }
  }

  Future<bool> updateSKUStock(SKUStock skuStock) async {
    return Geolocator.getCurrentPosition().then((value) async {
      final response = await http.post(
        Uri.parse(
            "https://asia-south1-hilifedb.cloudfunctions.net/updateSKUStock"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'SKUStockID': skuStock.SKUStockID.toString(),
          'SKUID': skuStock.SKUID.toString(),
          'distributorID': skuStock.distributorID.toString(),
          'primaryStock': skuStock.primaryStock.toString(),
          'alternativeStock': skuStock.alternativeStock.toString(),
          'secondaryAlternativeStock':
              skuStock.secondaryAlternativeStock.toString(),
          'updatedDate': DateTime.now().toString().substring(0, 19),
          'lat': value.latitude.toString(),
          'lng': value.longitude.toString(),
          'deactivated': skuStock.deactivated.toString()
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    });
  }
}
