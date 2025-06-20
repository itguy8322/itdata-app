import 'dart:convert';

import 'package:http/http.dart' as http;

class PurchaseService {
  Future<Map<String,dynamic>> purchaseAirtime(int networkId, int amount, String phone, String airtimeType) async {
    
    final url = Uri.parse('https://postranet.com/api/topup/');

    final headers = {
      'Content-Type': 'application/json',
      // Add authorization or API key here if required
      'Authorization': 'Token 94af83d1c32ff92892cfa4bfe7f7732f7a4c7925',
    };

    final body = jsonEncode({
      "network": networkId,
      "amount": amount,
      "mobile_number": phone,
      "Ported_number": true,
      "airtime_type": "VTU", // options: VTU, awuf4U, Share and Sell
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print("Success: ${response.body}");
      return response.body.isNotEmpty ? jsonDecode(response.body) : {};
    } else {
      print("Failed to purchase airtime: ${response.statusCode}");
      print(response.body);
      print("Error ${response.statusCode}: ${response.reasonPhrase}");
      return {
        "error": true,
        "message": "Failed to purchase airtime: ${response.reasonPhrase}"
      };
    }
  }
}