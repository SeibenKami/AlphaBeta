import 'dart:convert';

List<SearchModel> searchModelFromJson(String str) => List<SearchModel>.from(
    json.decode(str).map((x) => SearchModel.fromJson(x)));

String searchModelToJson(List<SearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchModel {
  SearchModel({
    required this.abstract,
    required this.abstractSource,
    required this.abstractText,
    required this.abstractUrl,
    required this.answer,
    required this.answerType,
    required this.definition,
    required this.definitionSource,
    required this.definitionUrl,
    required this.heading,
    required this.image,
    required this.redirect,
    required this.relatedTopics,
    required this.results,
    required this.type,
  });


  String abstract;
  String abstractSource;
  String abstractText;
  String abstractUrl;
  String answer;
  String answerType;
  String definition;
  String definitionSource;
  String definitionUrl;
  String heading;
  String image;
  String redirect;
  String relatedTopics;
  String results;
  String type;
  

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        abstract: json["Abstract"],
        abstractSource: json["AbstractSource"],
        abstractText: json["AbstractText"],
       abstractUrl: json["AbstractURL"],
        answer: json["Answer"],
        answerType: json["AnswerType"],
       definition: json["Definition"],
        definitionSource:json["DefinitionSource"],
        definitionUrl: json["DefinitionURL"],
        type: json["Type"],
        redirect: json["Redirect"],
        results: json["Results"],
        relatedTopics: json["RelatedTopics"],
        heading: json["Heading"],
        image: json["Image"]

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "address": address.toJson(),
        "phone": phone,
        "website": website,
        "company": company.toJson(),
      };
}

// class Address {
//   Address({
//     required this.street,
//     required this.suite,
//     required this.city,
//     required this.zipcode,
//     required this.geo,
//   });

//   String street;
//   String suite;
//   String city;
//   String zipcode;
//   Geo geo;

//   factory Address.fromJson(Map<String, dynamic> json) => Address(
//         street: json["street"],
//         suite: json["suite"],
//         city: json["city"],
//         zipcode: json["zipcode"],
//         geo: Geo.fromJson(json["geo"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "street": street,
//         "suite": suite,
//         "city": city,
//         "zipcode": zipcode,
//         "geo": geo.toJson(),
//       };
// }

// class Geo {
//   Geo({
//     required this.lat,
//     required this.lng,
//   });

//   String lat;
//   String lng;

//   factory Geo.fromJson(Map<String, dynamic> json) => Geo(
//         lat: json["lat"],
//         lng: json["lng"],
//       );

//   Map<String, dynamic> toJson() => {
//         "lat": lat,
//         "lng": lng,
//       };
// }

// class Company {
//   Company({
//     required this.name,
//     required this.catchPhrase,
//     required this.bs,
//   });

//   String name;
//   String catchPhrase;
//   String bs;

//   factory Company.fromJson(Map<String, dynamic> json) => Company(
//         name: json["name"],
//         catchPhrase: json["catchPhrase"],
//         bs: json["bs"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "catchPhrase": catchPhrase,
//         "bs": bs,
//       };
// }



// "Abstract":"DuckDuckGo is a search engine based in Valley Forge, Pennsylvania that uses information from crowd-sourced sites with the aim of augmenting traditional results and improving relevance."
// "AbstractSource":"Wikipedia"
// "AbstractText":"DuckDuckGo is a search engine based in Valley Forge, Pennsylvania that uses information from crowd-sourced sites with the aim of augmenting traditional results and improving relevance."
// "AbstractURL":"http://en.wikipedia.org/wiki/DuckDuckGo"
// "Answer":3
// "AnswerType":"calc"
// "Definition":"barge definition: any of various boats."
// "DefinitionSource":"Merriam-Webster"
// "DefinitionURL":"http://www.merriam-webster.com/dictionary/barge"
// "Heading":"DuckDuckGo"
// "Image":"http://i.duck.co/i/3f8af7d7.png"
// "Redirect":"http://www.imdb.com/find?s=all&q=rushmore"
// "RelatedTopics":[1 item