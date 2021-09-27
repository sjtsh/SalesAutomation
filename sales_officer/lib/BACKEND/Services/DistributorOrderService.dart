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
      bool orderStatus, String remarks, String dateAndTime) {
    Future<int> distributorID2 =
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
          'dateAndTime': dateAndTime.toString().substring(0, 19),
          'updatedTime': dateAndTime.toString().substring(0, 19),
          'lat': value.longitude.toString(),
          'lng': value.latitude.toString(),
          'deactivated':false.toString()
        }),
      );
      if (response.statusCode == 200) {
        List<dynamic> aList = jsonDecode(response.body);
        return aList[0]["0"];
      } else {
        return -1;
      }
    });
    return distributorID2;
  }

  Future<bool> updateDistributorOrder(DistributorOrder distributorOrder) async {
    final res = await http.put(
      Uri.parse(
          "https://asia-south1-hilifedb.cloudfunctions.net/updateDistributorOrder"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'distributorOrderID': distributorOrder.distributorOrderID.toString(),
          'distributorID': distributorOrder.distributorID.toString(),
          'SOID': distributorOrder.SOID.toString(),
          'joint': distributorOrder.joint.toString(),
          'orderStatus': distributorOrder.orderStatus.toString(),
          'remarks': distributorOrder.remarks.toString(),
          'dateAndTime': distributorOrder.dateAndTime.toString(),
          'updatedTime':
              distributorOrder.updatedTime.toString().substring(0, 19),
          'lat': distributorOrder.lat.toString(),
          'lng': distributorOrder.lng.toString(),
          'deactivated': distributorOrder.deactivated.toString(),
        },
      ),
    );
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
