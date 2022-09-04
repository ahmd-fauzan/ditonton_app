part of 'tv_list_bloc.dart';

abstract class TvListState extends Equatable {
  const TvListState();

  @override
  List<Object> get props => [];
}

class TVListEmpty extends TvListState {}

class TVListLoading extends TvListState {}

class TVListError extends TvListState {
  final String message;

  TVListError(this.message);

  @override
  List<Object> get props => [message];
}

class TVListHasData extends TvListState {
  final List<TV> result;

  TVListHasData(this.result);

  @override
  List<Object> get props => [result];
}
