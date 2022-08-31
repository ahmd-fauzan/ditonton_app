import 'dart:async';

import 'package:core/data/models/movie_series_model/movie_table.dart';
import 'package:core/data/models/tv_series_model/tv_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblMovieWatchlist = 'movieWatchlist';
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
    await db.execute('''
      CREATE TABLE  $_tblMovieWatchlist (
        movie_id INTEGER PRIMARY KEY,
        title TEXT,
        movie_overview TEXT,
        movie_posterPath TEXT
      );
    ''');
  }

  Future<int> insertMovieWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblMovieWatchlist, movie.toJson());
  }

  Future<int> insertTVWatchlist(TVTable tv) async {
    final db = await database;
    return await db!.insert(_tblTVWatchlist, tv.toJson());
  }

  Future<int> removeMovieWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblMovieWatchlist,
      where: 'movie_id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<int> removeTVWatchlist(TVTable tv) async {
    final db = await database;
    return await db!.delete(
      _tblTVWatchlist,
      where: 'tv_id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblMovieWatchlist,
      where: 'movie_id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
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

  Future<List<Map<String, dynamic>>> getMovieWatchlist() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblMovieWatchlist);

    return results;
  }

  Future<List<Map<String, dynamic>>> getTVWatchlist() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblTVWatchlist);

    return results;
  }
}
