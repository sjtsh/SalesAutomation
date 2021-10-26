import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';

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
