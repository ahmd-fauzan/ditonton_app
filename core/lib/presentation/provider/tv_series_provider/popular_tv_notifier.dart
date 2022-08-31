import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:core/domain/usecases/tv_usecase/get_popular_tv.dart';
import 'package:flutter/material.dart';

class PopularTVNotifier extends ChangeNotifier {
  final GetPopularTV getPopularTV;

  PopularTVNotifier({required this.getPopularTV});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TV> _tvList = [];
  List<TV> get tvList => _tvList;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTV() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTV.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvData) {
        _state = RequestState.Loaded;
        _tvList = tvData;
        notifyListeners();
      },
    );
  }
}
