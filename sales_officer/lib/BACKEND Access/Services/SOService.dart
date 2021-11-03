import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Entities/SO.dart';

class SOService{
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getSOs";

  Future<List<SO>> fetchSOs() async {
   try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> values = jsonDecode(response.body);
        List<SO> SOs = values.map((e) => SO.fromJson(e)).toList();
        return SOs;
      } else {
        throw Exception("failed to load post");
      }
    } on SocketException{
   throw Exception("failed to load post");
   }on TimeoutException{
     throw Exception("failed to load post");
   }
  }

}