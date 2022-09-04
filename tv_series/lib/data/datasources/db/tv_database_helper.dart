import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:tv_series/data/models/tv_table.dart';

class TvDatabaseHelper {
  static TvDatabaseHelper? _databaseHelper;
  TvDatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory TvDatabaseHelper() => _databaseHelper ?? TvDatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblTVWatchlist = 'tvWatchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton_db.db';

    var db = await openDatabase(databasePath, version: 4, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblTVWatchlist (
        tv_id INTEGER PRIMARY KEY,
        name TEXT,
        tv_overview TEXT,
        tv_posterPath TEXT
      );
      ''');
  }

  Future<int> insertTVWatchlist(TVTable tv) async {
    final db = await database;
    return await db!.insert(_tblTVWatchlist, tv.toJson());
  }

  Future<int> removeTVWatchlist(TVTable tv) async {
    final db = await database;
    return await db!.delete(
      _tblTVWatchlist,
      where: 'tv_id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTVById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblTVWatchlist,
      where: 'tv_id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getTVWatchlist() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblTVWatchlist);

    return results;
  }
}
