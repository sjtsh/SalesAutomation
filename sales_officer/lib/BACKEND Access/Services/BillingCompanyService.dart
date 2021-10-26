import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Entities/BillingCompany.dart';

class BillingCompanyService {
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getBillingCompanys";

  Future<List<BillingCompany>> fetchBillingCompanys() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> values = jsonDecode(response.body);
      List<BillingCompany> billingCompanys =
      values.map((e) => BillingCompany.fromJson(e)).toList();
      return billingCompanys;
    } else {
      throw Exception("failed to load post");
    }
  }
}
