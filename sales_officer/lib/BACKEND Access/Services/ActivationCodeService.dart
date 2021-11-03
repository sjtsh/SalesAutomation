import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND%20Access/Entities/ActivationCode.dart';


class ActivationCodeService {

  Future<List<ActivationCode>> fetchActivationCodes() async {
    int aStatuscode = 0;
    List<ActivationCode> activationCodes =[];

    while (aStatuscode != 200) {
      try {
        final response = await http.get(Uri.parse(
            "https://asia-south1-hilifedb.cloudfunctions.net/getActivationCodes"));
        aStatuscode = response.statusCode;
        List<dynamic> values = jsonDecode(response.body);
        List<ActivationCode> activationCodes =
        values.map((e) => ActivationCode.fromJson(e)).toList();
        if (response.statusCode == 200) {
          return activationCodes;
        } else {
          throw Exception("failed to load post");
        }
      } on SocketException {
        throw Exception("failed to load post");
      }
    }   return activationCodes;
  }
}
