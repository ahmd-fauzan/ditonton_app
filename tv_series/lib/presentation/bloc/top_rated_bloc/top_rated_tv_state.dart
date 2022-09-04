part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object> get props => [];
}

class TopRatedTVEmpty extends TopRatedTvState {}

class TopRatedTVLoading extends TopRatedTvState {}

class TopRatedTVError extends TopRatedTvState {
  final String message;

  TopRatedTVError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTVHasData extends TopRatedTvState {
  final List<TV> result;

  TopRatedTVHasData(this.result);

  @override
  List<Object> get props => [result];
}
