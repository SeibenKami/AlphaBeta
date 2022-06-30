import 'dart:convert';

List<SearchModel> searchModelFromJson(String str) => List<SearchModel>.from(
    json.decode(str).map((x) => SearchModel.fromJson(x)));

class SearchModel {
  SearchModel({
    required this.title,
    required this.cseImage,
    required this.cseThumbnail,
    required this.displaylink,
    required this.id,
    required this.link,
    required this.snippet,
    required this.thumbnailTitle,
  });
  String id;
  String title;
  String link;
  String displaylink;
  String snippet;
  String cseThumbnail;
  String cseImage;
  String thumbnailTitle;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        id: json['cacheId'] ?? '',
        title: json['title'],
        link: json['link'],
        displaylink: json['displayLink'],
        snippet: json['snippet'],
        cseThumbnail: json['pagemap'] != null &&json['pagemap']['cse_thumbnail']!=null
            ? json['pagemap']['cse_thumbnail'][0]['src']
            : "",
        cseImage: json['pagemap']['cse_image'] != null
            ? json['pagemap']['cse_image'][0]['src']
            : "",
        thumbnailTitle: json['pagemap']['metatags'] != null
            ? json['pagemap']['metatags'][0]['og:title'] ?? ""
            : "",
      );
}
