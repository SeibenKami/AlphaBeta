import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const _authority = "www.googleapis.com";
  static const _path = "/customsearch/v1";

  // Base API request to get response
  Future<Map<String, dynamic>> getSearches(String keyword) async {
    final Map<String, String> _headers = {
      "key": "AIzaSyDzYk-ElU3Nfqx0i3es5zyo0Z0eusIK20c",
      "cx": "4893808f27303c73a",
      'q': keyword,
    };
    Uri uri = Uri.https(_authority, _path, _headers);
    print(uri);
    final response = await http.get(uri);
    if (response.statusCode == HttpStatus.ok) {
      // If server returns an OK response, parse the JSON.
      final jsonMap = jsonDecode(response.body);
      return jsonMap;
    } else {
      // If that response was not OK, throw an error.
      throw Exception(
          'API call returned: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}
