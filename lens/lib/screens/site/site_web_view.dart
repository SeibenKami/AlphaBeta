import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lens/database/database.dart';
import 'package:lens/models/search_model.dart';
import 'package:lens/models/site_model.dart';
import 'package:lens/screens/browser/browser.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SiteView extends StatefulWidget {
  const SiteView({Key? key, required this.search}) : super(key: key);
  final SearchModel search;

  @override
  State<SiteView> createState() => _SiteViewState();
}

class _SiteViewState extends State<SiteView> {
  final TextEditingController searchController = TextEditingController();
  Completer<WebViewController> webController = Completer<WebViewController>();
  DBProvider dbProvider = DBProvider();
  bool isLoading = true;
  bool isFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.text = widget.search.link;
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
              readOnly: true,
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
                      dbProvider.updateSiteValue('isFavorite',
                          isFavorite ? 1 : 0, int.parse(widget.search.id));
                    },
                    icon: Icon(
                      isFavorite ? Icons.bookmark : Icons.bookmark_add_outlined,
                      color: isFavorite ? Colors.red : Colors.black,
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
            WebView(
              initialUrl: widget.search.link,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                dbProvider.addSite(Site(
                    search: widget.search,
                    searchDate: DateTime.now(),
                    isFavorite: false));
                setState(() {
                  isLoading = false;
                });
              },
              onWebViewCreated: (WebViewController webViewController) {
                webController.complete(webViewController);
              },
            ),
            isLoading
                ? const LinearProgressIndicator(
                    color: Colors.red,
                    backgroundColor: Colors.black,
                  )
                : Container(),
          ],
        )));
  }
}
