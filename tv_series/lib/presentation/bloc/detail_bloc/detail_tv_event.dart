part of 'detail_tv_bloc.dart';

abstract class DetailTvEvent extends Equatable {
  const DetailTvEvent();

  @override
  List<Object> get props => [];
}

class GetDetailTV extends DetailTvEvent {
  final int tvId;

  GetDetailTV(this.tvId);

  @override
  List<Object> get props => [tvId];
}

class FetchTvRecommendations extends DetailTvEvent {
  final int tvId;

  FetchTvRecommendations(this.tvId);

  @override
  List<Object> get props => [tvId];
}
