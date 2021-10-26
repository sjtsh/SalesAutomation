import 'dart:convert';

import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;

class DistributorReturnOrderService {
  insertDistributorReturnOrder(int distributorID, int SOID, bool joint,
      bool returnOrderStatus, String remarks) async {
    int distributorReturnOrderID = -1;

    await Geolocator.getCurrentPosition().then((value) async {
      final response = await http.post(
        Uri.parse(
            "https://asia-south1-hilifedb.cloudfunctions.net/insertDistributorReturnOrder"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'distributorID': distributorID.toString(),
          'SOID': SOID.toString(),
          'joint': joint.toString(),
          'returnOrderStatus': returnOrderStatus.toString(),
          'remarks': remarks,
          'dateAndTime': DateTime.now().toString().substring(0, 19),
          'updatedTime': DateTime.now().toString().substring(0, 19),
          'lat': value.longitude.toString(),
          'lng': value.latitude.toString(),
          'deactivated': false.toString(),
        }),
      );
      List<dynamic> aList = jsonDecode(response.body);
      distributorReturnOrderID = aList[0]["0"];
      return distributorReturnOrderID;
    });
    return distributorReturnOrderID;
  }
}
