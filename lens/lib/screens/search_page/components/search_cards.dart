import 'package:flutter/material.dart';
import 'package:lens/models/search_model.dart';
import 'package:lens/screens/settings/private_browsing/private_siteview.dart';
import 'package:lens/screens/site/site_web_view.dart';
import 'package:cached_network_image/cached_network_image.dart';


class SeacrhCard extends StatelessWidget {
  const SeacrhCard({
    Key? key,
    required this.search,
    this.isPrivate,
  }) : super(key: key);
  final SearchModel search;
  final bool? isPrivate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => isPrivate != null
                    ? isPrivate!
                        ? PrivateWebView(search: search)
                        : SiteView(search: search)
                    : SiteView(search: search)));
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /////Header
              Text(
                search.title,
                maxLines: 2,
                style: const TextStyle(
                    // color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis),
              ),
              const SizedBox(
                height: 5,
              ),

              ////Site title and logo
              Row(
                children: [
                  search.cseThumbnail.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: search.cseThumbnail,
                          height: 30,
                          width: 30,
                          fit: BoxFit.fill,
                        )
                      : Container(
                          height: 30,
                          width: 30,
                          color: Colors.green,
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      search.link,
                      maxLines: 1,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis, color: Colors.blue),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),

              ///Explanation
              Text(
                search.snippet,
                maxLines: 3,
                style: const TextStyle(
                    overflow: TextOverflow.ellipsis, fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
