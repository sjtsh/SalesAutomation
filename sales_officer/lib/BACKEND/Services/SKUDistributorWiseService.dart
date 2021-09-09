import 'dart:convert';
import 'package:sales_officer/BACKEND/Entities/SKUDistributorWise.dart';
import 'package:http/http.dart' as http;

class SKUDistributorWiseService {
  final String url = "https://asia-south1-hilifedb.cloudfunctions.net/getSKUDistributorWises";

  Future<List<SKUDistributorWise>> fetchSKUDistributorWises() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> values = jsonDecode(response.body);
      List<SKUDistributorWise> skuDistributorWises = values.map((e) => SKUDistributorWise.fromJson(e)).toList();
      return skuDistributorWises;
    } else {
      throw Exception("failed to load post");
    }
  }

}
