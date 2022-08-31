import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:core/domain/usecases/tv_usecase/get_popular_tv.dart';
import 'package:core/domain/usecases/tv_usecase/get_top_rated_tv.dart';
import 'package:core/domain/usecases/tv_usecase/get_tv_on_the_air.dart';
import 'package:flutter/material.dart';

class TVListNotifier extends ChangeNotifier {
  var _onTheAirTV = <TV>[];
  List<TV> get onTheAirTV => _onTheAirTV;

  RequestState _onTheAirTVState = RequestState.Empty;
  RequestState get onTheAirTVState => _onTheAirTVState;

  var _popularTV = <TV>[];
  List<TV> get popularTV => _popularTV;

  RequestState _popularTVState = RequestState.Empty;
  RequestState get popularTVState => _popularTVState;

  var _topRatedTV = <TV>[];
  List<TV> get topRatedTV => _topRatedTV;

  RequestState _topRatedTVState = RequestState.Empty;
  RequestState get topRatedTVState => _topRatedTVState;

  String _message = '';
  String get message => _message;

  TVListNotifier({
    required this.getOnTheAirTV,
    required this.getPopularTV,
    required this.getTopRatedTV,
  });

  final GetTVOnTheAir getOnTheAirTV;
  final GetPopularTV getPopularTV;
  final GetTopRatedTV getTopRatedTV;

  Future<void> fetchOnTheAirTV() async {
    _onTheAirTVState = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTV.execute();
    result.fold((failure) {
      _onTheAirTVState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvData) {
      _onTheAirTVState = RequestState.Loaded;
      _onTheAirTV = tvData;
      notifyListeners();
    });
  }

  Future<void> fetchPopularTV() async {
    _popularTVState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTV.execute();
    result.fold((failure) {
      _popularTVState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvData) {
      _popularTVState = RequestState.Loaded;
      _popularTV = tvData;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedTV() async {
    _topRatedTVState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTV.execute();
    result.fold((failure) {
      _topRatedTVState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvData) {
      _topRatedTVState = RequestState.Loaded;
      _topRatedTV = tvData;
      notifyListeners();
    });
  }
}
