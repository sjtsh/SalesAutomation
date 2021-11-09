import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../Entities/Distributor.dart';

class DistributorService {
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getDistributors";

  Future<List<Distributor>> fetchDistributors() async {
    List<Distributor> distributors = [];
    int aStatusCode = 0;
    while (aStatusCode != 200) {
      final response = await http.get(Uri.parse(url));
      aStatusCode = response.statusCode;

      if (response.statusCode == 200) {
        List<dynamic> values = jsonDecode(response.body);

        List<Distributor> distributors =
            values.map((e) => Distributor.fromJson(e)).toList();

        return distributors;

      } else {
        throw Exception("failed to load post");
      }
    }

    return distributors;
  }
}