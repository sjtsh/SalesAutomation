import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Entities/Familiarity.dart';

class NepaliDateService {
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getNepaliDate";

  Future<String> fetchNepaliDate() async {
    int aStatusCode = 0;
    while (aStatusCode !=200) {
      try {
        final response = await http.get(Uri.parse(url));
        aStatusCode = response.statusCode;
        if (response.statusCode == 200) {
          return response.body;
        } else {
          throw Exception("failed to load post");
        }
      } on SocketException {
        throw Exception("failed to load post");
      } on TimeoutException {
        throw Exception("failed to load post");
      }
    } throw Exception(" Something Went Wrong");
  }
}
