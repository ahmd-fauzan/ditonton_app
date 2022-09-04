import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super(MovieDetailEmpty()) {
    on<GetDetailMovie>((event, emit) async {
      final movieId = event.movieId;
      emit(MovieDetailLoading());

      final result = await _getMovieDetail.execute(movieId);
      result.fold(
        (failure) {
          emit(MovieDetailError(failure.message));
        },
        (data) {
          emit(MovieDetailHasData(data));
        },
      );
    });
  }
}

class MovieRecommendationsBloc
    extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecommendationsBloc(this._getMovieRecommendations)
      : super(MovieDetailEmpty()) {
    on<MovieRecommendations>(
      (event, emit) async {
        final int id = event.movieId;
        emit(MovieDetailLoading());
        final result = await _getMovieRecommendations.execute(id);
        result.fold(
          (failure) {
            emit(MovieDetailError(failure.message));
          },
          (data) {
            emit(MovieRecommendationsHasData(data));
          },
        );
      },
    );
  }
}

class AddMovieWatchlistBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final SaveMovieWatchlist _saveMovieWatchlist;
  final GetWatchListStatus _getWatchListStatus;
  final RemoveMovieWatchlist _removeMovieWatchlist;

  AddMovieWatchlistBloc(this._saveMovieWatchlist, this._getWatchListStatus,
      this._removeMovieWatchlist)
      : super(MovieDetailEmpty()) {
    on<SaveWatchlist>(
      (event, emit) async {
        final movieDetail = event.result;
        final result = await _saveMovieWatchlist.execute(movieDetail);
        result.fold(
          (failure) {
            emit(MovieDetailError(failure.message));
          },
          (data) {
            add(MovieWatchlistStatus(movieDetail.id));
          },
        );
      },
    );
    on<MovieWatchlistStatus>(
      ((event, emit) async {
        final int id = event.movieId;
        emit(MovieDetailLoading());
        final result = await _getWatchListStatus.execute(id);
        emit(MovieWatchlistStatusHasData(result));
      }),
    );
    on<RemoveWatchlist>((event, emit) async {
      final movieDetail = event.result;
      final result = await _removeMovieWatchlist.execute(movieDetail);
      result.fold(
        (failure) {
          emit(MovieDetailError(failure.message));
        },
        (data) {
          add(MovieWatchlistStatus(movieDetail.id));
        },
      );
    });
  }
}
