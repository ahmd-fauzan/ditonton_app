part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlist extends WatchlistTvEvent {}

class SaveWatchlist extends WatchlistTvEvent {
  final TVDetail result;

  SaveWatchlist(this.result);

  @override
  List<Object> get props => [result];
}

class RemoveWatchlist extends WatchlistTvEvent {
  final TVDetail result;

  RemoveWatchlist(this.result);

  @override
  List<Object> get props => [result];
}

class FetchWatchlistStatus extends WatchlistTvEvent {
  final int tvId;

  FetchWatchlistStatus(this.tvId);

  @override
  List<Object> get props => [tvId];
}
