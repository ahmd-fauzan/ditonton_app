import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:core/domain/usecases/tv_usecase/get_watchlist_tv.dart';
import 'package:flutter/material.dart';

class WatchlistTVNotifier extends ChangeNotifier {
  var _watchlistTV = <TV>[];
  List<TV> get watchlistTV => _watchlistTV;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTVNotifier({required this.getWatchlistTV});

  final GetWatchlistTV getWatchlistTV;

  Future<void> fetchWatchlistTV() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();
    final result = await getWatchlistTV.execute();
    result.fold((failure) {
      _message = failure.message;
      _watchlistState = RequestState.Error;
      notifyListeners();
    }, (data) {
      _watchlistTV = data;
      _watchlistState = RequestState.Loaded;
      notifyListeners();
    });
  }
}
