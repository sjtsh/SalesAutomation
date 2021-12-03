import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Entities/SO.dart';
import 'NepaliDateService.dart';

class SOService{
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getSOs";

  Future<List<SO>> fetchSOs() async {
    int aStockCode = 0;
    while (aStockCode!=200){
   try {
      final response = await http.get(Uri.parse(url));
      aStockCode = response.statusCode;
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
  } throw Exception("Something Went Wrong");
  }

  Future<bool> updateSO(
      final int SOID,
      final int ASMID,
      final int districtID,
      final String SOName,
      final String joiningDate,
      {String? homeLocation,
        int? PAN,
        int? phone,
        String? img,
        String? email,
        String? bankAccountName,
        String? bankAccountNumber,
        String? bankName,
        String? bankAddress,
        String? reportingManager,
        bool? maritalStatus,
        String? gender,
        String? DOB}
      ) async {
    Map<String, String> aMap = {};
    bool returnMessage =
    await NepaliDateService().fetchNepaliDate().then((date) async {
      aMap['SOID'] = SOID.toString();
      aMap['ASMID'] = ASMID.toString();
      aMap['districtID'] = districtID.toString();
      aMap['SOName'] = SOName.toString();
      homeLocation != null ? aMap['homeLocation'] = homeLocation: 1;
      PAN != null ? aMap['PAN'] = PAN.toString() : 2;
      phone != null ? aMap['phone'] = phone.toString() : 2;
      img != null ? aMap['img'] = img.toString() : 2;
      email != null ? aMap['email'] = email.toString() : 2;
      bankAccountName != null
          ? aMap['bankAccountName'] = bankAccountName.toString()
          : 2;
      bankAccountNumber != null
          ? aMap['bankAccountNumber'] = bankAccountNumber.toString()
          : 2;
      bankName != null ? aMap['bankName'] = bankName.toString() : 2;
      bankAddress != null ? aMap['bankAddress'] = bankAddress.toString() : 2;
      reportingManager != null
          ? aMap['reportingManager'] = reportingManager.toString()
          : 2;
      maritalStatus != null
          ? aMap['maritalStatus'] = maritalStatus.toString()
          : 2;
      gender != null ? aMap['gender'] = gender.toString() : 2;
      DOB != null ? aMap['DOB'] = DOB.toString() : 2;
      aMap["joiningDate"] = date;
      print(aMap);
      final res = await http.post(
        Uri.parse("https://asia-south1-hilifedb.cloudfunctions.net/updateSO"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(aMap),
      );
      if (res.statusCode == 200) {
        return true;
      }
      return false;
    });
    return returnMessage;
  }
}