import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND%20Access/Entities/SubGroup.dart';

class SubGroupService {
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getSubGroups";

  Future<List<SubGroup>> fetchSubGroups(context) async {
    int aStatusCode = 0;
    List<SubGroup> subGroups = [];

    while (aStatusCode != 200) {
      print(aStatusCode);
      try {
        final response = await http.get(Uri.parse(url));
        aStatusCode = response.statusCode;
        if (response.statusCode == 200) {
          List<dynamic> values = jsonDecode(response.body);
          subGroups = values.map((e) => SubGroup.fromJson(e)).toList();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Data Fetching Failed",
              textAlign: TextAlign.center,)));
        }
      } on SocketException {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content:Text("No Internet Connection",textAlign: TextAlign.center,)));
        continue;
      } on TimeoutException {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Sorry, Failed to Load Data",
            textAlign: TextAlign.center,)));
        continue;
      }
    }
    return subGroups;
  }
}
