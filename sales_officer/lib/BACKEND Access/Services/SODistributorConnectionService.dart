import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND%20Access/Entities/SODistributorConnection.dart';

import '../../Database.dart';

class SODistributorConnectionService {
  Future<List<SODistributorConnection>> fetchSODistributorConnections() async {
    int aStockcode = 0;
    while (aStockcode != 200) {
      try {
        final response = await http.post(Uri.parse(
            "https://asia-south1-hilifedb.cloudfunctions.net/getSODistributorConnection"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{"SOID": meSOID.toString()}),);
        aStockcode = response.statusCode;
        if (response.statusCode == 200) {
          List<dynamic> values = jsonDecode(response.body);
          List<SODistributorConnection> SODistributorConnections =
          values.map((e) => SODistributorConnection.fromJson(e)).toList();
          return SODistributorConnections;
        } else {
          throw Exception("failed to load post");
        }
      } on SocketException {
        throw Exception("failed to load post");
      } on TimeoutException {
        throw Exception("failed to load post");
      }
    } throw Exception("Something Went Wrong");
  }


}
