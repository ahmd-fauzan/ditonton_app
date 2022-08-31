import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:core/domain/entities/tv_entities/tv_detail.dart';
import 'package:core/domain/usecases/tv_usecase/get_tv_detail.dart';
import 'package:core/domain/usecases/tv_usecase/get_tv_recommendations.dart';
import 'package:core/domain/usecases/tv_usecase/get_watchlist_status_tv.dart';
import 'package:core/domain/usecases/tv_usecase/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/tv_usecase/save_watchlist_tv.dart';
import 'package:flutter/material.dart';

class TVDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVDetail getTVDetail;
  final GetTVRecommendations getTVRecommendations;
  final GetWatchlistStatusTV getWatchlistStatusTV;
  final SaveWatchlistTV saveWatchlistTV;
  final RemoveWatchlistTV removeWatchlistTV;

  TVDetailNotifier(
      {required this.getTVDetail,
      required this.getTVRecommendations,
      required this.getWatchlistStatusTV,
      required this.saveWatchlistTV,
      required this.removeWatchlistTV});

  late TVDetail _tvDetail;
  TVDetail get tvDetail => _tvDetail;

  List<TV> _tvRecommendations = [];
  List<TV> get tvRecommendations => _tvRecommendations;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedtoWatchlist => _isAddedtoWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchTVDetail(int id) async {
    _state = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTVDetail.execute(id);
    final recommendationResult = await getTVRecommendations.execute(id);
    detailResult.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (tv) {
      _tvDetail = tv;
      _state = RequestState.Loaded;
      _recommendationState = RequestState.Loading;
      notifyListeners();
      recommendationResult.fold((failure) {
        _recommendationState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      }, (tv) {
        _recommendationState = RequestState.Loaded;
        _tvRecommendations = tv;
        notifyListeners();
      });
    });
  }

  Future<void> addWatchlist(TVDetail tv) async {
    final result = await saveWatchlistTV.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );
    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeWatchlist(TVDetail tv) async {
    final result = await removeWatchlistTV.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (succesMessage) async {
        _watchlistMessage = succesMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchlistStatusTV.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
