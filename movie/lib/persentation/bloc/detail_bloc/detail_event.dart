part of 'detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class GetDetailMovie extends MovieDetailEvent {
  final int movieId;

  GetDetailMovie(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class MovieRecommendations extends MovieDetailEvent {
  final int movieId;

  MovieRecommendations(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class MovieWatchlistStatus extends MovieDetailEvent {
  final int movieId;

  MovieWatchlistStatus(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class SaveWatchlist extends MovieDetailEvent {
  final MovieDetail result;

  SaveWatchlist(this.result);

  @override
  List<Object> get props => [result];
}

class RemoveWatchlist extends MovieDetailEvent {
  final MovieDetail result;

  RemoveWatchlist(this.result);

  @override
  List<Object> get props => [result];
}
