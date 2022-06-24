import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lens/screens/browser/browser.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SiteView extends StatefulWidget {
  const SiteView({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<SiteView> createState() => _SiteViewState();
}

class _SiteViewState extends State<SiteView> {
  final TextEditingController searchController = TextEditingController();
  Completer<WebViewController> webController = Completer<WebViewController>();
  bool isLoading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.text = widget.url;
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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark_add_outlined,
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
            WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
              onWebViewCreated: (WebViewController webViewController) {
                webController.complete(webViewController);
                
              },
            ),
              isLoading ?const LinearProgressIndicator(color: Colors.red,backgroundColor: Colors.black,):Container(),
          ],
        )));
  }
}
