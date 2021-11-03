import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;

import '../Entities/Familiarity.dart';

class LastUpdatedService {
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getLastUpdateds";


  Future<String> fetchLastUpdateds() async {
    int aStatusCode = 0;

    while (aStatusCode != 200) {
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          List<dynamic> values = jsonDecode(response.body);
          // print(values[0]["0"]);
          return values[0]["0"];
        } else {
          throw Exception("failed to load post");
        }
      } catch (e) {
        return "0000-00-00 00:00:00";
      }
    } throw Exception("Something Went worng");
  }

  }

