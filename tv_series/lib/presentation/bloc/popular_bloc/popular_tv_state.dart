part of 'popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object> get props => [];
}

class PopularTVEmpty extends PopularTvState {}

class PopularTVLoading extends PopularTvState {}

class PopularTVError extends PopularTvState {
  final String message;

  PopularTVError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTVHasData extends PopularTvState {
  final List<TV> result;

  PopularTVHasData(this.result);

  @override
  List<Object> get props => [result];
}
