import 'package:flutter/material.dart';
import 'package:lens/my_connectivity.dart';
import 'package:lens/screens/browser/browser.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../models/search_model.dart';
import '../../../services/api_service.dart';
import '../../search_page/components/search_cards.dart';

class PrivateBrowsing extends StatefulWidget {
  const PrivateBrowsing({Key? key}) : super(key: key);

  @override
  State<PrivateBrowsing> createState() => _PrivateBrowsingState();
}

class _PrivateBrowsingState extends State<PrivateBrowsing> {
  final TextEditingController searchController = TextEditingController();
  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;
  int totalsearches = 0;
  int startIndex = 1;
  int currentPage = 1;
  int totalPages = 0;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  @override
  Widget build(BuildContext context) {
    var network = _source.keys.toList()[0];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
        title: SizedBox(
          height: 38,
          //////////////////////// Search Form Feild ////////////////////
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
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Search loading...")));
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
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Search loading...")));
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.private_connectivity,
              color: Colors.white,
              size: 29,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: network == ConnectivityResult.none
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
                        Colors.green.withOpacity(0.1),
                        Colors.green.withOpacity(0.4),
                      ],
                    )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: FutureBuilder<Map<String, dynamic>>(
                      future: ApiService()
                          .getSearches(searchController.text, startIndex),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final results = snapshot.data;
                          final engineTitle = results!["context"]['title'];
                          final sites = results['items'];
                          totalsearches = int.parse(
                              results['queries']['request'][0]['totalResults']);
                          totalPages = (totalsearches ~/ 10);
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // AppIcon
                                    Row(
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
                                    Row(
                                      children: [
                                        currentPage == 1
                                            ? Container()
                                            : SizedBox(
                                                width: 30,
                                                child: TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        startIndex =
                                                            startIndex - 10;
                                                        currentPage--;
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        "Loading previous page...")));
                                                      });
                                                    },
                                                    child: Icon(
                                                        Icons.arrow_back_ios)),
                                              ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        currentPage == totalPages
                                            ? Container()
                                            : SizedBox(
                                                width: 30,
                                                child: TextButton(
                                                    onPressed: () {
                                                      if (currentPage <
                                                          totalPages) {
                                                        setState(() {
                                                          startIndex =
                                                              startIndex + 10;
                                                          currentPage++;
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          "Loading next page...")));
                                                        });
                                                      }
                                                    },
                                                    child: Icon(Icons
                                                        .arrow_forward_ios)),
                                              ),
                                      ],
                                    )
                                  ],
                                ),
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
                                          thumbnailTitle:
                                              searched.thumbnailTitle,
                                        ),
                                        isPrivate: true,
                                      );
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
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
