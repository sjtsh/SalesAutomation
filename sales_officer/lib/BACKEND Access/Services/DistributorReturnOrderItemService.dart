import 'dart:convert';
import 'package:http/http.dart' as http;

class DistributorReturnOrderItemService {
  Future<bool> insertDistributorReturnOrderItem(
      int distributorReturnOrderID,
      int SKUID,
      int primaryItemCount,
      int alternativeItemCount,
      int secondaryAlternativeItemCount,
      String reason) async {
    final response = await http.post(
      Uri.parse(
          "https://asia-south1-hilifedb.cloudfunctions.net/insertDistributorReturnOrderItem"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'distributorReturnOrderID': distributorReturnOrderID.toString(),
        'SKUID': SKUID.toString(),
        'primaryItemCount': primaryItemCount.toString(),
        'alternativeItemCount': alternativeItemCount.toString(),
        'secondaryAlternativeItemCount':
            secondaryAlternativeItemCount.toString(),
        'reason': reason,
        'deactivated': false.toString()
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
