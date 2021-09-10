import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Entities/Familiarity.dart';

class FamiliarityService {
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getFamiliaritys";

  Future<List<Familiarity>> fetchFamiliaritys() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> values = jsonDecode(response.body);
      List<Familiarity> familiaritys =
          values.map((e) => Familiarity.fromJson(e)).toList();
      return familiaritys;
    } else {
      throw Exception("failed to load post");
    }
  }
}
