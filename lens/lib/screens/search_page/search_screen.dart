import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lens/screens/browser/browser.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.keyword}) : super(key: key);
  final String keyword;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
   Completer<WebViewController> webController = Completer<WebViewController>();

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
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_add_outlined,
                    color: Colors.black,
                    size: 20,
                  ),
                )),
            onFieldSubmitted: (value) {
              searchController.text=value;
            },
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
      ),
      body: SafeArea(
          child: WebView(
        initialUrl: "https://google.com/search?q=${searchController.text}",
        javascriptMode: JavascriptMode.unrestricted,
         onWebViewCreated: (WebViewController webViewController) {
           webController.complete(webViewController);
        },
              )),
    );
  }
}
