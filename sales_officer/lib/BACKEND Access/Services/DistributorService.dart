import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../Entities/Distributor.dart';
import 'NepaliDateService.dart';

class DistributorService {
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getDistributors";

  Future<List<Distributor>> fetchDistributors() async {
    List<Distributor> distributors = [];
    int aStatusCode = 0;
    while (aStatusCode != 200) {
      final response = await http.get(Uri.parse(url));
      aStatusCode = response.statusCode;

      if (response.statusCode == 200) {
        List<dynamic> values = jsonDecode(response.body);

        List<Distributor> distributors =
            values.map((e) => Distributor.fromJson(e)).toList();

        return distributors;

      } else {
        throw Exception("failed to load post");
      }
    }

    return distributors;
  }

  Future<bool> updateDistributor(
      final int distributorID,
      final String distributorName,
      final String distributorType,
      final int townID, {
        String? distributorERPID,
        String? email,
        // String assignedSo,

        int? mobileNumber,
        int? phone,
        String? ownerName,
        int? PAN,
        String? bankName,
        String? bankAddress,
        String? bankAccountName,
        String? bankAccountNumber,
        String? location,
        String? img,
        int? VAT,
        double? lat,
        double? lng,
      }) async {
    Map<String, String> aMap = {};
      aMap['distributorID'] = distributorID.toString();
      aMap['distributorName'] = distributorName.toString();
      aMap['distributorType'] = distributorType.toString();
      aMap['townID'] = townID.toString();
      distributorERPID != null ? aMap['distributorERPID'] = distributorERPID: 2;
      email != null ? aMap['email'] = email.toString() : 2;
      mobileNumber != null ? aMap['mobileNumber'] = mobileNumber.toString(): 2;
      phone != null ? aMap['phone'] = phone.toString() : 2;
      ownerName != null ? aMap['ownerName'] = ownerName: 2;
      PAN != null ? aMap['PAN'] = PAN.toString() : 2;
      bankName != null ? aMap['bankName'] = bankName.toString() : 2;
      bankAddress != null ? aMap['bankAddress'] = bankAddress.toString() : 2;
      bankAccountName != null
          ? aMap['bankAccountName'] = bankAccountName.toString()
          : 2;
      bankAccountNumber != null
          ? aMap['bankAccountNumber'] = bankAccountNumber.toString()
          : 2;
      location != null ? aMap['location'] = location :2;
      img != null ? aMap['img'] = img.toString() : 2;
      VAT != null
          ? aMap['VAT'] = VAT.toString()
          : 2;
      lat != null
          ? aMap['lat'] = lat.toString()
          : 2;
      lng != null ? aMap['lng'] = lng.toString() : 2;
      print(aMap);
      final res = await http.post(
        Uri.parse("https://asia-south1-hilifedb.cloudfunctions.net/updateDistributor"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(aMap),
      );
      if (res.statusCode == 200) {
        return true;
      }
      return false;
  }
}