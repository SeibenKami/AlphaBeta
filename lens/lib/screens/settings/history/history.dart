import 'package:flutter/material.dart';
import 'package:lens/database/database.dart';
import 'package:lens/models/search_model.dart';
import 'package:lens/models/site_model.dart';
import 'package:lens/screens/search_page/components/search_cards.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  DBProvider dbProvider = DBProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        titleSpacing: 0,
        title: const Text(
         'History',
         style: TextStyle(fontWeight: FontWeight.bold),
            ),
        actions:const  [  Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.history,color: Colors.white,),
        ),],
      ),
      body: FutureBuilder<List<Site>>(
        future: dbProvider.readAllSites(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final results = snapshot.data;
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Site site = results![index];
                  return SeacrhCard(
                      search: SearchModel(
                    title: site.search.title,
                    cseImage: site.search.cseImage,
                    cseThumbnail: site.search.cseThumbnail,
                    displaylink: site.search.displaylink,
                    id: site.search.id,
                    link: site.search.link,
                    snippet: site.search.snippet,
                    thumbnailTitle: site.search.thumbnailTitle,
                  ));
                });
          } else {
            return const Center(
                child: Text(
              " No search history",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ));
          }
        },
      ),
    );
  }
}
