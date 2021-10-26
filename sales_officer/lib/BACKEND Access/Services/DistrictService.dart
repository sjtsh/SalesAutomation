import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND%20Access/Entities/District.dart';
import '../Entities/Familiarity.dart';

class DistrictService {
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getDistricts";

  Future<List<District>> fetchDistricts() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> values = jsonDecode(response.body);
      List<District> districts =
      values.map((e) => District.fromJson(e)).toList();
      return districts;
    } else {
      throw Exception("failed to load post");
    }
  }
}
