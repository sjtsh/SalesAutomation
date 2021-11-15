import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrderItem.dart';

import '../../Database.dart';

class DistributorOrderItemService {
  Future<List<DistributorOrderItem>> fetchDistributorOrderItems(context) async {
    int aStatusCode = 0;
    List<DistributorOrderItem> distributorOrderItems = [];
    while (aStatusCode != 200) {
      try {
        final response = await http.post(
          Uri.parse(
              "https://asia-south1-hilifedb.cloudfunctions.net/getDistributorOrderItem"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{"SOID": meSOID.toString()}),
        );
        if (response.statusCode == 200) {
          List<dynamic> values = jsonDecode(response.body);
          List<DistributorOrderItem> distributorOrderItems =
              values.map((e) => DistributorOrderItem.fromJson(e)).toList();
          return distributorOrderItems;
        } else {
          throw Exception("failed to load post");
        }
      } on SocketException {
        throw Exception("failed to load post");
      } on TimeoutException {
        throw Exception("failed to load post");
      }
    }
    return distributorOrderItems;
  }

  Future<bool> insertDistributorOrderItem(
      int distributorOrderID,
      int SKUID,
      int primaryItemCount,
      int alternativeItemCount,
      int secondaryAlternativeItemCount) async {
    final response = await http.post(
      Uri.parse(
          "https://asia-south1-hilifedb.cloudfunctions.net/insertDistributorOrderItem"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'distributorOrderID': distributorOrderID.toString(),
          'SKUID': SKUID.toString(),
          'primaryItemCount': primaryItemCount.toString(),
          'alternativeItemCount': alternativeItemCount.toString(),
          'secondaryAlternativeItemCount':
              secondaryAlternativeItemCount.toString(),
          'deactivated': false.toString(),
        },
      ),
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> updateDistributorOrderItem(
    DistributorOrderItem distributorOrderItem,
  ) async {
    try {
      final res = await http.put(
        Uri.parse(
            "https://asia-south1-hilifedb.cloudfunctions.net/updateDistributorOrderItem"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'distributorOrderItemID':
                distributorOrderItem.distributorOrderItemID.toString(),
            'distributorOrderID':
                distributorOrderItem.distributorOrderID.toString(),
            'SKUID': distributorOrderItem.SKUID.toString(),
            'primaryItemCount':
                distributorOrderItem.primaryItemCount.toString(),
            'alternativeItemCount':
                distributorOrderItem.alternativeItemCount.toString(),
            'secondaryAlternativeItemCount':
                distributorOrderItem.secondaryAlternativeItemCount.toString(),
            'deactivated': distributorOrderItem.deactivated.toString()
          },
        ),
      );
      if (res.statusCode == 200) {
        return true;
      }
      return false;
    } on SocketException {
      throw Exception("failed to load post");
    } on TimeoutException {
      throw Exception("failed to load post");
    }
  }
}
