
import 'package:flutter/material.dart';
import 'package:lens/screens/settings/bookmarks/bookmarks.dart';
import 'package:lens/screens/settings/history/history.dart';
import 'package:lens/screens/settings/private_browsing/private_browsing.dart';
import 'package:provider/provider.dart';
import '../../components/item_card.dart';
import '../../providers/theme_provider.dart';

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
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
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
                      padding: const EdgeInsets.only(left: 16),
                      child: const Text(
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
                     ////////////////// Dark theme change ///////////////////////////
                    ItemCard(
                      title:
                          themeChange.darkTheme ? 'Dark Theme' : 'Light Theme',
                      color: Colors.black,
                      rightWidget: SizedBox(
                        width: 30,
                        child: Checkbox(
                            value: themeChange.darkTheme,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                                side: const BorderSide(
                                    color: Colors.black12, width: 0.1)),
                            side: const BorderSide(
                                color: Colors.black38, width: 1),
                            onChanged: (bool? value) {
                              themeChange.darkTheme = value!;
                            }),
                      ),
                      callback: () {
                        
                      },
                    ),

                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 16),
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
                     ////////////////// History ///////////////////////////
                    ItemCard(
                      title: 'History',
                      color: Colors.grey.shade900,
                      rightWidget: _arrow(),
                      callback: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const History()));
                      },
                    ),
                     ////////////////// Bookmarks ///////////////////////////
                    ItemCard(
                      title: 'Bookmarks',
                      color: Colors.grey.shade900,
                      rightWidget: _arrow(),
                      callback: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookMarks()));
                      },
                    ),
                     ////////////////// Private Search ///////////////////////////
                    ItemCard(
                      title: 'Private Search',
                      color: Colors.black,
                      rightWidget: const Icon(Icons.privacy_tip),
                      callback: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PrivateBrowsing()));
                      },
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                     ////////////////// App Version ///////////////////////////
                    ItemCard(
                      title: 'Version',
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
                     ////////////////// Team ///////////////////////////
                    ItemCard(
                      title: 'Developers',
                      color: Colors.grey.shade900,
                      rightWidget: const Center(
                        child: Text('AlphaBeta',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      callback: () {},
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
