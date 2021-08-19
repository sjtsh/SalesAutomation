import 'dart:convert';

import 'package:sales_officer/BACKEND/Entities/SKU.dart';
import 'package:sales_officer/BACKEND/Entities/SubGroup.dart';

import 'package:http/http.dart' as http;

class SKUService {
  final String url = "https://asia-south1-hilifedb.cloudfunctions.net/getSKUs";

  Future<List<SKU>> fetchSKUs() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> values = jsonDecode(response.body);
      List<SKU> SKUs = values.map((e) => SKU.fromJson(e)).toList();
      return SKUs;
    } else {
      throw Exception("failed to load post");
    }
  }
}
