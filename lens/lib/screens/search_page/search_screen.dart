import 'package:flutter/material.dart';
import 'package:lens/models/search_model.dart';
import 'package:lens/my_connectivity.dart';
import 'package:lens/screens/browser/browser.dart';
import 'package:lens/screens/search_page/components/search_cards.dart';
import 'package:lens/screens/settings/bookmarks/bookmarks.dart';
import 'package:lens/screens/settings/history/history.dart';
import 'package:lens/screens/settings/private_browsing/private_browsing.dart';
import 'package:lens/services/api_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.keyword}) : super(key: key);
  final String keyword;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;
  bool showMenu = false;

  @override
  void initState() {
    super.initState();
    searchController.text = widget.keyword;
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  @override
  Widget build(BuildContext context) {
    var network = _source.keys.toList()[0];
    return Scaffold(
      ////////////////// App Bar ////////////////////////
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Browser()));
          },
          child: const Icon(
            Icons.home,
            size: 29,
            color: Colors.white,
          ),
        ),
        titleSpacing: 0,
        //////////////////////// Search Form Feild ////////////////////
        title: SizedBox(
          height: 38,
          child: TextFormField(
            controller: searchController,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 12),
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.greenAccent)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white)),
                hintText: 'Search for web address',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 20,
                  ),
                )),
            onFieldSubmitted: (value) {
              searchController.text = value;
              setState(() {});
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                 ////////////////// Menu List ///////////////////////////
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                          padding: const EdgeInsets.only(top: 60, right: 10),
                          child: menuItems());
                    });
              },
              icon: Icon(
                Icons.menu,
                size: 28,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: network == ConnectivityResult.none
            //////////////////// GIF if no network /////////////////
            ? SizedBox(
                child: Center(
                    child: Image.asset(
                  'assets/gif/conn.gif',
                  height: 220,
                  width: 220,
                  fit: BoxFit.cover,
                )),
              )
            : Stack(
                children: [
                  //BAckground
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      colors: [
                        Colors.green.withOpacity(0),
                        Colors.green.withOpacity(0.1),
                        Colors.green.withOpacity(0.4),
                      ],
                    )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: FutureBuilder<Map<String, dynamic>>(
                      future: ApiService().getSearches(searchController.text),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final results = snapshot.data;
                          final engineTitle = results!["context"]['title'];
                          final sites = results['items'];
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    //color: Colors.blue,
                                    child: Image(
                                        image: AssetImage(
                                            "assets/images/placeholder.png")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "$engineTitle",
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'fantasy',
                                          fontSize: 25),
                                    ),
                                  ),
                                ],
                              ),
                              ////////////////// List of searched sites ///////////////////////////
                              Expanded(
                                child: ListView.builder(
                                    itemCount: sites.length,
                                    itemBuilder: (context, index) {
                                      SearchModel searched =
                                          SearchModel.fromJson(sites[index]);
                                      return SeacrhCard(
                                          search: SearchModel(
                                        title: searched.title,
                                        cseImage: searched.cseImage,
                                        cseThumbnail: searched.cseThumbnail,
                                        displaylink: searched.displaylink,
                                        id: searched.id,
                                        link: searched.link,
                                        snippet: searched.snippet,
                                        thumbnailTitle: searched.thumbnailTitle,
                                      ));
                                    }),
                              ),
                            ],
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: Colors.green,
                          ));
                        } else {
                          return const Center(
                              child: Text(
                            "No data found",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ));
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget menuItems() {
    return Align(
        alignment: Alignment.topRight,
        child: SizedBox(
          width: 250,
           height: 180,
          child: Material(
            child: ListView(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const History())));
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.history,
                    ),
                    title: Text('History'),
                  ),
                ),
                InkWell(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BookMarks()));
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.bookmarks,
                      ),
                      title: Text('Bookmarks'),
                    )),
                InkWell(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PrivateBrowsing()));
                    },
                    child: const ListTile(
                      leading: Icon(Icons.privacy_tip),
                      title: Text('Private Browsing'),
                    ))
              ],
            ),
          ),
        ));
  }
}
