import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Entities/Familiarity.dart';

class LastUpdatedService {
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getLastUpdateds";

  Future<String> fetchLastUpdateds() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> values = jsonDecode(response.body);
      return values[0]["0"];
    } else {
      throw Exception("failed to load post");
    }
  }
}
