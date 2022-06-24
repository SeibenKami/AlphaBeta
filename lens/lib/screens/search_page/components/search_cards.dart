import 'package:flutter/material.dart';
import 'package:lens/screens/site/site_web_view.dart';

class SeacrhCard extends StatelessWidget {
  const SeacrhCard({
    Key? key,
    required this.title,
    required this.cseImage,
    required this.cseThumbnail,
    required this.displaylink,
    required this.id,
    required this.link,
    required this.snippet,
    required this.thumbnailTitle,
  }) : super(key: key);
  final String id;
  final String title;
  final String link;
  final String displaylink;
  final String snippet;
  final String cseThumbnail;
  final String cseImage;
  final String thumbnailTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SiteView(url: link)));
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
                title,
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
                  cseThumbnail.isNotEmpty
                      ? Image.network(
                          cseThumbnail,
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
                      link,
                      maxLines: 1,
                      style: const TextStyle(overflow: TextOverflow.ellipsis,color: Colors.blue),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),

              ///Explanation
              Text(
                snippet,
                maxLines: 3,
                style: const TextStyle(overflow: TextOverflow.ellipsis,fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
