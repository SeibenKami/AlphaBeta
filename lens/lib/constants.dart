import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return isDarkTheme ? ThemeData.dark() : ThemeData.light();
  }
}
