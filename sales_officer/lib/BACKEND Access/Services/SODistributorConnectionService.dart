import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND%20Access/Entities/SODistributorConnection.dart';

class SODistributorConnectionService {
  Future<List<SODistributorConnection>> fetchSODistributorConnections() async {
    final response = await http.get(Uri.parse(
        "https://asia-south1-hilifedb.cloudfunctions.net/getSODistributorConnections"));
    if (response.statusCode == 200) {
      List<dynamic> values = jsonDecode(response.body);
      List<SODistributorConnection> SODistributorConnections =
          values.map((e) => SODistributorConnection.fromJson(e)).toList();
      return SODistributorConnections;
    } else {
      throw Exception("failed to load post");
    }
  }
}
