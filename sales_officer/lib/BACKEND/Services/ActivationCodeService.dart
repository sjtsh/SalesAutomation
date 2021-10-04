import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND/Entities/ActivationCode.dart';

class ActivationCodeService {
  Future<List<ActivationCode>> fetchActivationCodes() async {
    final response = await http.get(Uri.parse(
        "https://asia-south1-hilifedb.cloudfunctions.net/getActivationCodes"));
    List<dynamic> values = jsonDecode(response.body);
    List<ActivationCode> activationCodes =
        values.map((e) => ActivationCode.fromJson(e)).toList();
    if (response.statusCode == 200) {
      return activationCodes;
    } else {
      throw Exception("failed to load post");
    }
  }
}
