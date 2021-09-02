import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND/Entities/DistributorOrder.dart';

class DistributorOrderService {
  Future<List<DistributorOrder>> fetchDistributorOrders() async {
    final response = await http.get(Uri.parse(
        "https://asia-south1-hilifedb.cloudfunctions.net/getDistributorOrders"));
    if (response.statusCode == 200) {
      List<dynamic> values = jsonDecode(response.body);
      List<DistributorOrder> distributorOrders =
          values.map((e) => DistributorOrder.fromJson(e)).toList();
      return distributorOrders;
    } else {
      throw Exception("failed to load post");
    }
  }

  Future<int> insertDistributorOrder(int distributorID, int SOID, bool joint,
      bool orderStatus, String remarks, String dateAndTime) async {
    Geolocator.getCurrentPosition().then((value) async {
      final response = await http.post(
        Uri.parse(
            "https://asia-south1-hilifedb.cloudfunctions.net/insertDistributorOrder"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
        'distributorID': distributorID.toString(),
        'SOID': SOID.toString(),
        'joint': joint.toString(),
        'orderStatus': orderStatus.toString(),
        'remarks': remarks,
        'dateAndTime': dateAndTime.toString().substring(0,19),
        'updatedTime': dateAndTime.toString().substring(0,19),
        'lat' : value.longitude.toString(),
        'lng' : value.latitude.toString()
        }),
      );
      List<dynamic> aList =  jsonDecode(response.body);
      int distributorID2 = aList[0]["0"];
      if (response.statusCode == 200) {
        return distributorID2;
      }
      return -1;
    });
    return -1;
  }
}