import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Entities/Familiarity.dart';

class FamiliarityService {
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getFamiliaritys";


  Future<List<Familiarity>> fetchFamiliaritys(context) async {
    try{
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> values = jsonDecode(response.body);
        List<Familiarity> familiaritys =
            values.map((e) => Familiarity.fromJson(e)).toList();
        return familiaritys;

      } else {
        throw Exception("failed to load post");
      }
    }on SocketException{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Text("No Internet Connection",textAlign:TextAlign.center ),));
      throw Exception("failed to load post");
    }on TimeoutException{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Text("Sorry, Failed to Load Data",textAlign:TextAlign.center ),));
      throw Exception("failed to load post");
    }


  }
}
