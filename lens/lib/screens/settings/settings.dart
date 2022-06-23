import 'package:flutter/material.dart';

import '../../components/item_card.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Widget _arrow() {
    return Icon(
      Icons.arrow_forward_ios,
      size: 20.0,
      color: Color(0xFF999999),
    );
  }
  Widget _settings() {
    return Icon(
      Icons.settings,
      size: 20.0,
      color: Color(0xFF999999),
    );
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Color(0xFF000000),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                color: Color(0xFF000000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'App Settings',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ItemCard(
                      textColor: Color(0xFF999999),
                      title: 'Settings Item 01',
                      color: Colors.black,
                      rightWidget: _settings(),
                      callback: () {
                        print('Tap Settings Item 01');
                      },
                    ),
                    ItemCard(
                      textColor: Color(0xFF999999),
                      title: 'Settings Item 01',
                      color: Colors.black,
                      rightWidget:  _settings(),
                      callback: () {
                        print('Tap Settings Item 01');
                      },
                    ),
                    ItemCard(
                      title: 'Settings Item 06',
                      color: Colors.black,
                      rightWidget: _settings(),
                      callback: () {
                        print('Tap Settings Item 06');
                      },
                      textColor: Color(0xFF999999),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Others',
                        style: TextStyle(
                          fontFamily: 'NotoSansJP',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ItemCard(
                      textColor: Colors.white,
                      title: 'Settings Item 02',
                      color: Colors.grey.shade900,
                      rightWidget: _arrow(),
                      callback: () {
                        print('Tap Settings Item 02');
                      },
                    ),
                    ItemCard(
                      textColor: Colors.white,
                      title: 'Settings Item 03',
                      color: Colors.grey.shade900,
                      rightWidget: _arrow(),
                      callback: () {
                        print('Tap Settings Item 03');
                      },
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    ItemCard(
                      rightWidget: Container(),
                      title: 'Settings Item 09',
                      color: Colors.grey.shade900,
                      callback: () {
                        print('Tap Settings Item 09');
                      },
                      textColor: Color(0xFF999999),
                    ),
                    ItemCard(
                      textColor: Colors.red,
                      title: 'version',
                      color: Colors.grey.shade900,
                      rightWidget: Center(
                        child: Text('1.0.0',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      callback: () {},
                    ),
                    SizedBox(
                      height: 200,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
