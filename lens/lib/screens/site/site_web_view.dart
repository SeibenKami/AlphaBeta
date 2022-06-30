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
    super.initState();
    searchController.text = widget.search.link;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
         ////////////////////////App Bar ////////////////////
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
            title: SizedBox(
              height: 38,
              //////////////////////// Search Form Feild ////////////////////
              child: TextFormField(
                controller: searchController,
                readOnly: true,
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
                ),
                onFieldSubmitted: (value) {
                  searchController.text = value;
                },
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  dbProvider.updateSiteValue(
                      'isFavorite', isFavorite ? 1 : 0, widget.search.id);
                  setState(() {
                    isFavorite=!isFavorite;
                  });
                },
                icon: Icon(
                  isFavorite ? Icons.bookmark : Icons.bookmark_add_outlined,
                  color: isFavorite ? Colors.red : Colors.white,
                  size: 27,
                ),
              )
            ],
          ),
          body: SafeArea(
              child: Stack(
            children: [
              WebView(
                initialUrl: widget.search.link,
                javascriptMode: JavascriptMode.unrestricted, 
                onPageStarted: (finish) {
                  ////////////////////////Add site to database  ////////////////////
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
                      backgroundColor: Colors.green,
                    )
                  : Container(),
            ],
          ))),
    );
  }
}
