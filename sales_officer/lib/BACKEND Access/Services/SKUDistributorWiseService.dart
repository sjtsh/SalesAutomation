import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND%20Access/Entities/SKUDistributorWise.dart';

class SKUDistributorWiseService {
  final String url = "https://asia-south1-hilifedb.cloudfunctions.net/getSKUDistributorWises";

  Future<List<SKUDistributorWise>> fetchSKUDistributorWises() async {
    int aStatusCode = 0;
    while (aStatusCode != 200) {
      try {
        final response = await http.get(Uri.parse(url));
        aStatusCode = response.statusCode;

        if (response.statusCode == 200) {
          List<dynamic> values = jsonDecode(response.body);
          List<SKUDistributorWise> skuDistributorWises =
          values.map((e) => SKUDistributorWise.fromJson(e)).toList();
          return skuDistributorWises;
        } else {
          throw Exception("failed to load post");
        }
      } on SocketException {
        throw Exception("failed to load post");
      } on TimeoutException {
        throw Exception("failed to load post");
      }
    }throw Exception("Something Went Wrong");
  }
  }
