import 'package:flutter/material.dart';
import 'package:lens/screens/home/homepage.dart';
import 'package:lens/screens/settings/settings.dart';

class Browser extends StatefulWidget {
  const Browser({Key? key}) : super(key: key);

  @override
  State<Browser> createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  final pagecontroller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pagecontroller,
      children: const [
        HomePage(),
        Settings(),
      ],
    );
  }
}
