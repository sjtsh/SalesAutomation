import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';

class SKUService {
  final String url = "https://asia-south1-hilifedb.cloudfunctions.net/getSKUs";

  Future<List<SKU>> fetchSKUs() async {
    int aStatusCode = 0;
    while (aStatusCode != 200) {
      try {
        final response = await http.get(Uri.parse(url));
        aStatusCode =response.statusCode;
        if (response.statusCode == 200) {
          List<dynamic> values = jsonDecode(response.body);
          List<SKU> SKUs = values.map((e) => SKU.fromJson(e)).toList();
          return SKUs;
        } else {
          throw Exception("failed to load post");
        }
      } on SocketException {
        throw Exception("No internet connection");
      }
      on TimeoutException {
        throw Exception("Failed to load post, time out");
      }
    } throw Exception("Something Went Wrong ");
  }
}
