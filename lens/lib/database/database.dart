import 'dart:io';
import 'package:lens/models/site_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider();
  static final DBProvider db = DBProvider._init();
  static Database? _database;
  static String? databasePath;

  DBProvider._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final dbPath = appDocDir.path;
    final path = join(dbPath, 'lens.db');
    databasePath = path;
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    ).catchError((e) {
      print("$e");
    });
  }

  Future _createDB(Database db, int version) async {
    const text = "TEXT NOT NULL";
    await db.execute('''CREATE TABLE Sites ( 
          id $text PRIMARY KEY,
          title $text,
          searchDate $text,
          link $text,
          displaylink $text,
          snippet $text,
          cseThumbnail $text,
          cseImage $text,
          thumbnailTitle $text,
          isFavorite INTEGER NOT NULL
        );
      ''').then((value) {});
  }

  Future addSite(Site site) async {
    final _db = await database;
    await _db.insert("Sites", site.toJson());
  }

  Future<void> deleteSite(int id) async {
    final _db = await database;
    await _db.delete(
      "Sites",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Site> readSite(int id) async {
    final _db = await database;
    final map = await _db.query(
      "Sites",
      columns: Site.values,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (map.isNotEmpty) {
      return Site.fromJson(map.first);
    } else {
      throw Exception("ID $id not found");
    }
  }

  Future<int> updateSiteValue(String key, dynamic value, int id) async {
    final _db = await database;
    return _db.update(
      "Sites",
      {key: value},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Site>> readFavoriteSites() async {
    final _db = await database;
    final result = await _db.query("Sites",
        where: 'isFavorite = ?', whereArgs: [1], orderBy: "searchDate ASC");
    if (result.isNotEmpty) {
      return result.map((e) => Site.fromJson(e)).toList();
    } else {
      throw Exception("Not Sites found");
    }
  }

  Future<List<Site>> readAllSites() async {
    final _db = await database;
    final result = await _db.query("Sites", orderBy: "searchDate ASC");
    if (result.isNotEmpty) {
      return result.map((e) => Site.fromJson(e)).toList();
    } else {
      throw Exception("Not sites found");
    }
  }

  Future close() async {
    _database!.close();
  }
}
