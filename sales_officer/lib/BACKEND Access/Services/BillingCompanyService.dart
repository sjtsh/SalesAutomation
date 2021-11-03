import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Entities/BillingCompany.dart';

class BillingCompanyService {
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getBillingCompanys";
  Future<List<BillingCompany>> fetchBillingCompanys(context) async {
    int aStatuscode = 0;
    List<BillingCompany> billingCompany =[];

    while (aStatuscode != 200) {
      try {
        final response = await http.get(Uri.parse(url));
        aStatuscode = response.statusCode;
        if (response.statusCode == 200) {
          List<dynamic> values = jsonDecode(response.body);
          List<BillingCompany> billingCompany =
              values.map((e) => BillingCompany.fromJson(e)).toList();
          return billingCompany;
        } else {
          throw Exception("failed to load post");
        }
      } on SocketException {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "No Internet Connection",
            textAlign: TextAlign.center,
          ),

        ));
        throw Exception("failed to load post");
      } on TimeoutException {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Sorry, Failed to Load Data",
          textAlign: TextAlign.center,
        )));
        throw Exception("failed to load post");
      }
    }
    return billingCompany;
  }
}
