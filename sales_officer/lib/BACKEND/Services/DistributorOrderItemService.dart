import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND/Entities/DistributorOrderItem.dart';

class DistributorOrderItemService {
  final String url =
      "https://asia-south1-hilifedb.cloudfunctions.net/getDistributorOrderItems";

  Future<List<DistributorOrderItem>> fetchDistributorOrderItems() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> values = jsonDecode(response.body);
      List<DistributorOrderItem> distributorOrderItems =
          values.map((e) => DistributorOrderItem.fromJson(e)).toList();
      return distributorOrderItems;
    } else {
      throw Exception("failed to load post");
    }
  }

  Future<bool> insertDistributorOrderItem(
      int distributorOrderID,
      int SKUID,
      int primaryItemCount,
      int alternativeItemCount,
      int secondaryAlternativeItemCount) async {
    final response = await http.post(
      Uri.parse(
          "https://asia-south1-hilifedb.cloudfunctions.net/insertDistributorOrderItem"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'distributorOrderID': distributorOrderID.toString(),
        'SKUID': SKUID.toString(),
        'primaryItemCount': primaryItemCount.toString(),
        'alternativeItemCount': alternativeItemCount.toString(),
        'secondaryAlternativeItemCount':
            secondaryAlternativeItemCount.toString(),
      }),
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }


  Future<bool> updateDistributorOrderItem(DistributorOrderItem distributorOrderItem) async {
    final res = await http.put(
      Uri.parse("https://asia-south1-hilifedb.cloudfunctions.net/updateDistributorOrderItem"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'distributorOrderItemID': distributorOrderItem.distributorOrderItemID.toString(),
          'distributorOrderID' : distributorOrderItem.distributorOrderID.toString(),
          'SKUID' : distributorOrderItem.SKUID.toString(),
          'primaryItemCount' : distributorOrderItem.primaryItemCount.toString(),
          'alternativeItemCount' : distributorOrderItem.alternativeItemCount.toString(),
          'secondaryAlternativeItemCount' : distributorOrderItem.secondaryAlternativeItemCount.toString(),
        },
      ),
    );
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }
}
