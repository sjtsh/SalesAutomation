import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SOLogInDetail.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SOLogInDetail.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SOLogInDetail.dart';
import 'package:sales_officer/BACKEND%20Access/Services/NepaliDateService.dart';
import 'package:sales_officer/Database.dart';

import '../Entities/SO.dart';

class SOLogInDetailService {
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getSOLogInDetails";

  Future<List<SOLogInDetail>> fetchSOLogInDetails() async {
    int aStockCode = 0;
    while (aStockCode != 200) {
      try {
        final response = await http.get(Uri.parse(url));
        aStockCode = response.statusCode;
        if (response.statusCode == 200) {
          List<dynamic> values = jsonDecode(response.body);
          List<SOLogInDetail> soLogInDetail =
              values.map((e) => SOLogInDetail.fromJson(e)).toList();
          return soLogInDetail;
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


  Future<int> logIn() async {
    Future<int> soLogInDetailsID =  Geolocator.getCurrentPosition().then((location) {
      NepaliDateService nepaliDateService = NepaliDateService();
      Future<int> soLogInDetailsID = nepaliDateService.fetchNepaliDate().then((date) async {
        final response = await http.post(
          Uri.parse("https://asia-south1-hilifedb.cloudfunctions.net/insertSOLogInDetail"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'SOID': meSOID.toString(),
            'date': date.substring(0, 10),
            'logInTime': date.substring(12, 20),
            'logInLat': location.latitude.toString(),
            'logInLng': location.longitude.toString(),
          }),
        );
        if (response.statusCode == 200) {
          List<dynamic> aList = jsonDecode(response.body);
          return aList[0]["0"];
        } else {
          return -1;
        }
      });
      return soLogInDetailsID;
    });
    return soLogInDetailsID;
  }

  Future<void> updateSOLogInDetail(
    int SOLogInDetailID,
  ) async {
    Geolocator.getCurrentPosition().then((location) {
      NepaliDateService nepaliDateService = NepaliDateService();
      nepaliDateService.fetchNepaliDate().then((date) async {
        http.put(
          Uri.parse(
              "https://asia-south1-hilifedb.cloudfunctions.net/updateDistributorOrder"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, String>{
              'SOLogInDetailID': SOLogInDetailID.toString(),
              'logOutTime': date.substring(12, 20),
              'logOutLat': location.latitude.toString(),
              'logOutLng': location.longitude.toString(),
            },
          ),
        );
      });
    });
  }
}
