part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object> get props => [];
}

class WatchlistTVEmpty extends WatchlistTvState {}

class WatchlistTVLoading extends WatchlistTvState {}

class WatchlistTVError extends WatchlistTvState {
  final String message;

  WatchlistTVError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTVHasData extends WatchlistTvState {
  final List<TV> result;

  WatchlistTVHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistStatusHasData extends WatchlistTvState {
  final bool result;

  WatchlistStatusHasData(this.result);

  @override
  List<Object> get props => [result];
}
