import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND%20Access/Entities/SubGroup.dart';

class SubGroupService{
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getSubGroups";

  Future<List<SubGroup>> fetchSubGroups() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> values = jsonDecode(response.body);
      List<SubGroup> subGroups =
      values.map((e) => SubGroup.fromJson(e)).toList();
      return subGroups;
    } else {
      throw Exception("failed to load post");
    }
  }
}