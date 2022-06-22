import 'dart:convert';

import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/search_model.dart';

class ApiService {
  static const _authority =
      "duckduckgo-duckduckgo-zero-click-info.p.rapidapi.com";
  static const _path = "/";
  static const _query = {'q': 'food'};
  static const Map<String, String> _headers = {
    "x-rapidapi-key": "df9658cceemshcd079235447e76cp13f9bdjsnebe5aed6aa47",
    "x-rapidapi-host": "duckduckgo-duckduckgo-zero-click-info.p.rapidapi.com",
  };

  // Base API request to get response
  Future<SearchModel> get() async {
    Uri uri = Uri.https(_authority, _path, _query);
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == HttpStatus.ok) {
      // If server returns an OK response, parse the JSON.
      final jsonMap = jsonDecode(response.body);
      return SearchModel.fromJson(jsonMap);
    } else {
      // If that response was not OK, throw an error.
      throw Exception(
          'API call returned: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}
