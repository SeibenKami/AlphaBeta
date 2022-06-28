import 'package:flutter/material.dart';

class ApiConstants {
  static String baseUrl =
      'https://duckduckgo-duckduckgo-zero-click-info.p.rapidapi.com/';
  static String usersEndpoint = '/users';
}

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return isDarkTheme ? ThemeData.dark() : ThemeData.light();
  }
}
