import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';

import '../../Database.dart';

class DistributorOrderService {
  Future<List<DistributorOrder>> fetchDistributorOrder(context) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://asia-south1-hilifedb.cloudfunctions.net/getDistributorOrder"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"SOID": meSOID.toString()}),
      );
      if (response.statusCode == 200) {
        List<dynamic> values = jsonDecode(response.body);
        List<DistributorOrder> distributorOrders =
            values.map((e) => DistributorOrder.fromJson(e)).toList();
        return distributorOrders;
      } else {
        throw Exception("failed to load post");
      }
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "No Internet Connection",
        textAlign: TextAlign.center,
      )));
      throw Exception("failed to load post");
    } on TimeoutException {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("Sorry, Failed to Load Data", textAlign: TextAlign.center)));
      throw Exception("failed to load post");
    }
  }

  Future<List<DistributorOrder>> fetchDistributorOrders(context) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://asia-south1-hilifedb.cloudfunctions.net/getDistributorOrders"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"SOID": meSOID.toString()}),
      );
      if (response.statusCode == 200) {
        List<dynamic> values = jsonDecode(response.body);
        List<DistributorOrder> distributorOrders =
        values.map((e) => DistributorOrder.fromJson(e)).toList();
        return distributorOrders;
      } else {
        throw Exception("failed to load post");
      }
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "No Internet Connection",
            textAlign: TextAlign.center,
          )));
      throw Exception("failed to load post");
    } on TimeoutException {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
          Text("Sorry, Failed to Load Data", textAlign: TextAlign.center)));
      throw Exception("failed to load post");
    }
  }

  Future<int> insertDistributorOrder(int distributorID, int SOID, bool joint,
      bool orderStatus, String dateAndTime,
      {String? remarks}) {
    Future<int> distributorID2 =
        Geolocator.getCurrentPosition().then((value) async {
      Map<String, String> aMap = {};

      aMap['distributorID'] = distributorID.toString();
      aMap['SOID'] = SOID.toString();
      aMap['joint'] = joint.toString();
      aMap['orderStatus'] = orderStatus.toString();
      remarks != null ? aMap['remarks'] = remarks : 1;

      aMap['dateAndTime'] = dateAndTime.toString().substring(0, 19);
      aMap['updatedTime'] = dateAndTime.toString().substring(0, 19);
      aMap['lat'] = value.longitude.toString();
      aMap['lng'] = value.latitude.toString();
      aMap['deactivated'] = false.toString();

      final response = await http.post(
        Uri.parse(
            "https://asia-south1-hilifedb.cloudfunctions.net/insertDistributorOrder"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(aMap),
      );
      if (response.statusCode == 200) {
        List<dynamic> aList = jsonDecode(response.body);
        return aList[0]["0"];
      } else {
        return -1;
      }
    });
    return distributorID2;
  }

  Future<bool> updateDistributorOrder(DistributorOrder distributorOrder) async {
    Map<String, String> aMap = {};

    aMap['distributorOrderID'] = distributorOrder.distributorOrderID.toString();

    aMap['distributorID'] = distributorOrder.distributorID.toString();
    aMap['SOID'] = distributorOrder.SOID.toString();
    aMap['joint'] = distributorOrder.joint.toString();
    aMap['orderStatus'] = distributorOrder.orderStatus.toString();
    aMap['remarks'] = distributorOrder.remarks.toString();

    aMap['dateAndTime'] = distributorOrder.dateAndTime.toString();
    aMap['updatedTime'] =
        distributorOrder.updatedTime.toString().substring(0, 19);

    aMap['lat'] = distributorOrder.lat.toString();

    aMap['lng'] = distributorOrder.lng.toString();
    aMap['deactivated'] = distributorOrder.deactivated.toString();

    final res = await http.put(
      Uri.parse(
          "https://asia-south1-hilifedb.cloudfunctions.net/updateDistributorOrder"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(aMap),
    );
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
