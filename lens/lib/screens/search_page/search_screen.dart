import 'package:flutter/material.dart';
import 'package:lens/models/search_model.dart';
import 'package:lens/screens/browser/browser.dart';
import 'package:lens/screens/search_page/components/search_cards.dart';
import 'package:lens/services/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.keyword}) : super(key: key);
  final String keyword;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.text = widget.keyword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Browser()));
          },
          icon: const Icon(
            Icons.home,
            size: 28,
          ),
        ),
        leadingWidth: 12,
        title: SizedBox(
          height: 38,
          child: TextFormField(
            controller: searchController,
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
                    setState(() {});},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 20,
                  ),
                )),
            onFieldSubmitted: (value) {
              searchController.text = value;
            },
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
      ),
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
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder<Map<String, dynamic>>(
                future: ApiService().getSearches(widget.keyword),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final results = snapshot.data;
                    final engineTitle = results!["context"]['title'];
                    final sites = results['items'];
                    return Column(
                      children: [
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
                  } else {
                    return const Center(
                        child: Text(
                      "Searcing ...",
                      style: TextStyle(fontSize: 18, color: Colors.white),
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
}
