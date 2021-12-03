import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND%20Access/Entities/SKUStockTrack.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SOActivity.dart';

import '../../Database.dart';

class SKUStockTrackService {
  Future<List<SKUStockTrack>> fetchSKUStockTrack() async {
    int aStockCode = 0;
    while (aStockCode != 200) {
      try {
        final response = await http.post(
          Uri.parse(
              "https://asia-south1-hilifedb.cloudfunctions.net/getSKUStockTrack"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, String>{
              "SOID": meSOID!.toString(),
            },
          ),
        );
        aStockCode = response.statusCode;
        if (response.statusCode == 200) {
          List<dynamic> values = jsonDecode(response.body);
          List<SKUStockTrack> SKUStockTracks =
              values.map((e) => SKUStockTrack.fromJson(e)).toList();
          return SKUStockTracks;
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

  Future<bool> insertSKUStockTrack(
    int SOID,
    int distributorID,
    String dateAndTime,
  ) async {
    final response = await http.post(
      Uri.parse(
          "https://asia-south1-hilifedb.cloudfunctions.net/insertSKUStockTrack"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          "SOID": SOID.toString(),
          "distributorID": distributorID.toString(),
          "dateAndTime": dateAndTime.toString(),
        },
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
    print("SKUStockTrack Insert unsuccessful");
      return false;
    }
  }
}
