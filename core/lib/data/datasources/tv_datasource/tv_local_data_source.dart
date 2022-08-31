import 'package:core/core.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/models/tv_series_model/tv_table.dart';

abstract class TVLocalDataSource {
  Future<String> insertWatchlistTV(TVTable tv);
  Future<String> removeWatchlistTV(TVTable tv);
  Future<TVTable?> getByIdTV(int id);
  Future<List<TVTable>> getWatchlistTV();
}

class TVLocalDataSourceImpl implements TVLocalDataSource {
  final DatabaseHelper databaseHelper;

  TVLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistTV(TVTable tv) async {
    try {
      await databaseHelper.insertTVWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTV(TVTable tv) async {
    try {
      await databaseHelper.removeTVWatchlist(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TVTable?> getByIdTV(int id) async {
    final result = await databaseHelper.getTVById(id);
    if (result != null) {
      return TVTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TVTable>> getWatchlistTV() async {
    final result = await databaseHelper.getTVWatchlist();
    return result.map((data) => TVTable.fromMap(data)).toList();
  }
}
