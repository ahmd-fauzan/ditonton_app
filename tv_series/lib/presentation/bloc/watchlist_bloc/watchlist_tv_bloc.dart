import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_on_the_air.dart';
import 'package:tv_series/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv.dart';
import 'package:tv_series/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv_series/domain/usecases/save_watchlist_tv.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTV _getWatchlistTV;
  final GetWatchlistStatusTV _getWatchlistStatusTV;
  final SaveWatchlistTV _saveWatchlistTV;
  final RemoveWatchlistTV _removeWatchlistTV;

  WatchlistTvBloc(this._getWatchlistTV, this._getWatchlistStatusTV,
      this._saveWatchlistTV, this._removeWatchlistTV)
      : super(WatchlistTVEmpty()) {
    on<FetchWatchlist>((event, emit) async {
      emit(WatchlistTVLoading());
      final result = await _getWatchlistTV.execute();

      result.fold(
        (failure) {
          emit(WatchlistTVError(failure.message));
        },
        (data) {
          emit(WatchlistTVHasData(data));
        },
      );
    });

    on<FetchWatchlistStatus>(
      (event, emit) async {
        final id = event.tvId;
        emit(WatchlistTVLoading());
        final result = await _getWatchlistStatusTV.execute(id);
        emit(WatchlistStatusHasData(result));
      },
    );

    on<SaveWatchlist>(
      (event, emit) async {
        final tvDetail = event.result;
        emit(WatchlistTVLoading());
        final result = await _saveWatchlistTV.execute(tvDetail);
        result.fold(
          (failure) {
            emit(WatchlistTVError(failure.message));
          },
          (data) {
            add(FetchWatchlistStatus(tvDetail.id));
          },
        );
      },
    );

    on<RemoveWatchlist>(
      (event, emit) async {
        final tvDetail = event.result;
        emit(WatchlistTVLoading());
        final result = await _removeWatchlistTV.execute(tvDetail);
        result.fold(
          (failure) {
            emit(WatchlistTVError(failure.message));
          },
          (data) {
            add(FetchWatchlistStatus(tvDetail.id));
          },
        );
      },
    );
  }
}
