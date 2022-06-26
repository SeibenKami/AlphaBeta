import 'package:flutter/material.dart';
import 'package:lens/screens/browser/browser.dart';

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
  @override
  Widget build(BuildContext context) {
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
        child: Stack(
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
                future: ApiService().getSearches(searchController.text),
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
                            "$engineTitle - Private Mode",
                            style: const TextStyle(
                                color: Colors.black,
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

                                ),
                                isPrivate: true,);
                              }),
                        ),
                      ],
                    );
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