import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Entities/Distributor.dart';

class DistributorService {

  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getDistributors";


  Future<List<Distributor>> fetchDistributors() async {
    try{
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> values = jsonDecode(response.body);
        List<Distributor> distributors =
            values.map((e) => Distributor.fromJson(e)).toList();
        return distributors;

      } else {
        throw Exception("failed to load post");
      }
    }catch(e) {
      print(" Failed, No connectivity");
      throw Exception("failed to load post");

    }
    }

}
