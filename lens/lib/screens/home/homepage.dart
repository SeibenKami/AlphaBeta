import 'package:flutter/material.dart';
import 'package:lens/database/database.dart';
import 'package:lens/models/site_model.dart';
import 'package:lens/screens/search_page/search_screen.dart';
import 'package:lens/screens/settings/history/history.dart';
import 'package:lens/screens/settings/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _searchFormKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();
  DBProvider dbProvider = DBProvider();

  void startSearch(String value) {
    if (_searchFormKey.currentState!.validate()) {
      _searchFormKey.currentState!.save();
      if (value.isNotEmpty) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchScreen(keyword: value)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            // height: size.height,
            width: double.infinity,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //Browser details
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 50,
                              width: 50,
                              //color: Colors.blue,
                              child: Image(
                                  image: AssetImage(
                                      "assets/images/placeholder.png")),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'lens',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'fantasy',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    /////Search textfeild
                    Form(
                      key: _searchFormKey,
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'Search for web address',
                            suffixIcon: IconButton(
                              onPressed: () {
                                startSearch(searchController.text);
                              },
                              icon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            )),
                        onFieldSubmitted: (value) {
                          startSearch(value);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            startSearch(searchController.text);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 13, 202, 168),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5),
                            child: Text(
                              "Search",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    ///
                  ],
                ),
              ),

              /////////Recent Searches
              Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Recent Pages',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const History()));
                            },
                            child: const Text(
                              'see all >>',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                          child: FutureBuilder<List<Site>>(
                              future: dbProvider.readAllSites(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final results = snapshot.data;
                                  return ListView.builder(
                                      itemCount: snapshot.data!.length >= 2
                                          ? 2
                                          : snapshot.data!.length,
                                      itemBuilder: ((context, index) {
                                        Site site = results![index];
                                        return ListTile(
                                          title: Text(
                                            site.search.title,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                site.search.link,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              Text(
                                                site.search.snippet,
                                                maxLines: 3,
                                                style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ],
                                          ),
                                          isThreeLine: true,
                                        );
                                      }));
                                } else {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.history,
                                          size: 30,
                                        ),
                                        Text('No searches found')
                                      ],
                                    ),
                                  );
                                }
                              })),
                    ],
                  ))
            ]),
          ),
          ///////ADD Tab and dark mode
          Positioned(
            top: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Settings()));
                      },
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(5))),
                      child: const Icon(Icons.settings)),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
