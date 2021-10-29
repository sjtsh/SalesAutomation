import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Entities/Familiarity.dart';

class NepaliDateService {
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getNepaliDate";

  Future<String> fetchNepaliDate() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("failed to load post");
    }
  }
}
