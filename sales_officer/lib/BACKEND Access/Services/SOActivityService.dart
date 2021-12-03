import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND%20Access/Entities/SOActivity.dart';
import 'package:sales_officer/BACKEND%20Access/Services/NepaliDateService.dart';

class SOActivityService {
  Future<List<SOActivity>> fetchSOActivitys() async {
    int aStockCode = 0;
    while (aStockCode != 200) {
      try {
        final response = await http.get(Uri.parse(
            "https://asia-south1-hilifedb.cloudfunctions.net/getSOActivitys"));
        aStockCode = response.statusCode;
        if (response.statusCode == 200) {
          List<dynamic> values = jsonDecode(response.body);
          List<SOActivity> SOActivitys =
              values.map((e) => SOActivity.fromJson(e)).toList();
          return SOActivitys;
        } else {
          throw Exception("failed to load post");
        }
      } on SocketException {
        throw Exception("failed to load post");
      } on TimeoutException {
        throw Exception("failed to load post");
      }
    }
    throw Exception("Something Went Wrong");
  }

  Future<bool> insertSOActivity(
    int SOID,
    int distributorID,
    int taskID,
    String remark,
  ) async {
    final response = await NepaliDateService().fetchNepaliDate().then((time) {
      return http.post(
        Uri.parse(
            "https://asia-south1-hilifedb.cloudfunctions.net/insertSOActivity"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "SOID": SOID.toString(),
            "distributorID": distributorID.toString(),
            "taskID": taskID.toString(),
            "remark": remark,
            "dateAndTime": time
          },
        ),
      );
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
