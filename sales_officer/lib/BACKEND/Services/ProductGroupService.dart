import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND/Entities/ProductGroup.dart';


class ProductGroupService {
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getProductGroups";

  Future<List<ProductGroup>> fetchProductGroups() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> values = jsonDecode(response.body);
      List<ProductGroup> productGroups =
      values.map((e) => ProductGroup.fromJson(e)).toList();
      return productGroups;
    } else {
      throw Exception("failed to load post");
    }
  }
}
