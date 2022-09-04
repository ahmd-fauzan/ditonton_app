part of 'list_bloc.dart';

abstract class ListState extends Equatable {
  const ListState();

  @override
  List<Object> get props => [];
}

class ListEmpty extends ListState {}

class ListLoading extends ListState {}

class ListError extends ListState {
  final String message;

  ListError(this.message);

  @override
  List<Object> get props => [message];
}

class ListHasData extends ListState {
  final List<Movie> result;

  ListHasData(this.result);

  @override
  List<Object> get props => [result];
}
