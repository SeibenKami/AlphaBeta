import 'package:flutter/material.dart';
import '../../components/item_card.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Widget _arrow() {
    return const Icon(
      Icons.arrow_forward_ios,
      size: 20.0,
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding:const EdgeInsets.only(left: 16),
                      child:const Text(
                        'App Settings',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ItemCard(
                      title: 'New Tab',
                      color: Colors.black,
                      rightWidget:const Icon(Icons.add),
                      callback: () {
                        print('Tap Settings Item 01');
                      },
                    ),
                    ItemCard(
                      title: 'Private Search',
                      color: Colors.black,
                      rightWidget: const Icon(Icons.privacy_tip),
                      callback: () {
                        print('Tap Settings Item 01');
                      },
                    ),
                    ItemCard(
                      title: 'Dark Theme',
                      color: Colors.black,
                      rightWidget:const Icon(Icons.dark_mode),
                      callback: () {
                        print('Tap Settings Item 06');
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding:const EdgeInsets.only(left: 16),
                      child: const Text(
                        'Others',
                        style: TextStyle(
                          fontFamily: 'NotoSansJP',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ItemCard(
                      title: 'History',
                      color: Colors.grey.shade900,
                      rightWidget: _arrow(),
                      callback: () {
                        print('Tap Settings Item 02');
                      },
                    ),
                    ItemCard(
                      title: 'Bookmarks',
                      color: Colors.grey.shade900,
                      rightWidget: _arrow(),
                      callback: () {
                        print('Tap Settings Item 03');
                      },
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    ItemCard(
                      title: 'version',
                      color: Colors.grey.shade900,
                      rightWidget: const Center(
                        child: Text('1.0.0',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      callback: () {},
                    ),
                    const SizedBox(
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
