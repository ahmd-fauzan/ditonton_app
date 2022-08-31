import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:search/domain/usecases/search_tv.dart';

class TVSearchNotifier extends ChangeNotifier {
  final SearchTV searchTV;

  TVSearchNotifier({required this.searchTV});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  List<TV> _saerchResult = [];
  List<TV> get saerchResult => _saerchResult;

  Future<void> fetchTVSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();
    final result = await searchTV.execute(query);
    result.fold((failure) {
      _state = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvData) {
      _saerchResult = tvData;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
