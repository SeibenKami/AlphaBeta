import 'package:flutter/material.dart';
import 'package:lens/database/database.dart';
import 'package:lens/screens/home/homepage.dart';
import 'package:lens/screens/settings/settings.dart';

class Browser extends StatefulWidget {
  const Browser({Key? key}) : super(key: key);

  @override
  State<Browser> createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  final DBProvider _dbProvider = DBProvider();
  final pagecontroller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _dbProvider.database;
  }
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
