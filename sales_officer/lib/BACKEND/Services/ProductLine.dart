import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND/Entities/ProductLine.dart';
import 'package:sales_officer/BACKEND/Entities/Unit.dart';


class ProductLineService {
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getProductLines";

  Future<List<ProductLine>> fetchProductLines() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> values = jsonDecode(response.body);
      List<ProductLine> productLines =
      values.map((e) => ProductLine.fromJson(e)).toList();
      return productLines;
    } else {
      throw Exception("failed to load post");
    }
  }
}
