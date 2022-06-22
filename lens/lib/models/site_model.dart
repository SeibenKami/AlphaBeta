class Site {
  static final List<String> values = [
    "id",
    "description",
    "title",
    "isFavorite",
    "searchDate",
    "link"
  ];

  final int? id;
  final String description;
  final String title;
  final String link;
  final DateTime searchDate;
  final bool isFavorite;

  Site({
    this.id,
    required this.title,
    required this.searchDate,
    required this.isFavorite,
    required this.link,
    required this.description,
  });

  Site copy({
    final int? id,
    final String? title,
    final DateTime? searchDate,
    final bool? isFavorite,
     final String ? link,
     final String ? description,
  }) =>
      Site(
        id: id ?? this.id,
        title: title ?? this.title,
        searchDate: searchDate ?? this.searchDate,
        isFavorite: isFavorite ?? this.isFavorite,
        link: link??this.link,
        description: description??this.description,
      );

  static Site fromJson(Map<String, dynamic> json) => Site(
        id: json['id'],
        title: json['title'],
        searchDate: DateTime.parse(json['searchDate']),
        isFavorite: json['isFavorite']==1,
        link: json['link'],
        description: json['description']
      );

  Map<String,dynamic> toJson() => {
        "id": id,
        "title": title,
        "searchDate": searchDate.toIso8601String(),
        "isFavorite": isFavorite ? 1 : 0,
        "link":link,
        "description":description,
      };
}
