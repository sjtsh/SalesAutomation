import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND%20Access/Entities/Unit.dart';


class UnitService {
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getUnits";

  Future<List<Unit>> fetchUnits() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> values = jsonDecode(response.body);
      List<Unit> units =
      values.map((e) => Unit.fromJson(e)).toList();
      return units;
    } else {
      throw Exception("failed to load post");
    }
  }
}
