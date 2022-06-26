import 'package:lens/models/search_model.dart';

class Site {
  static final List<String> values = [
    "id",
    "title",
    "isFavorite",
    "searchDate",
    "link",
    'displaylink',
    'snippet',
    'cseThumbnail',
    'cseImage',
    'thumbnailTitle',
  ];
  final SearchModel search;
  final DateTime searchDate;
  final bool isFavorite;

  Site({
    required this.search,
    required this.searchDate,
    required this.isFavorite,
  });

  static Site fromSearchModel(SearchModel search) =>
      Site(search: search, isFavorite: false, searchDate: DateTime.now());

  static Site fromJson(Map<String, dynamic> json) => Site(
        search: SearchModel(
          id: json['id'],
          title: json['title'],
          cseImage: json['cseImage'],
          cseThumbnail: json['cseThumbnail'],
          displaylink: json['displaylink'],
          link: json['link'],
          snippet: json['snippet'],
          thumbnailTitle: json['thumbnailTitle'],
        ),
        searchDate: DateTime.parse(json['searchDate']),
        isFavorite: json['isFavorite'] == 1,
      );

  Map<String, dynamic> toJson() => {
        "id": search.id,
        "title": search.title,
        "searchDate": searchDate.toIso8601String(),
        "isFavorite": isFavorite ? 1 : 0,
        "link": search.link,
        'displaylink': search.displaylink,
        'snippet': search.snippet,
        'cseThumbnail': search.cseThumbnail,
        'cseImage': search.cseImage,
        'thumbnailTitle': search.thumbnailTitle
      };
}
