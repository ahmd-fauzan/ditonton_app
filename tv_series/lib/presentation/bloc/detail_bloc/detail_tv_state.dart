part of 'detail_tv_bloc.dart';

abstract class DetailTvState extends Equatable {
  const DetailTvState();

  @override
  List<Object> get props => [];
}

class DetailTVEmpty extends DetailTvState {}

class DetailTVLoading extends DetailTvState {}

class DetailTVError extends DetailTvState {
  final String message;

  DetailTVError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailTVHasData extends DetailTvState {
  final TVDetail result;

  DetailTVHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvRecommendationsHasData extends DetailTvState {
  final List<TV> result;

  TvRecommendationsHasData(this.result);

  @override
  List<Object> get props => [result];
}
