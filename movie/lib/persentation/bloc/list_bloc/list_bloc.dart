import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

part 'list_event.dart';
part 'list_state.dart';

class MovieListBloc extends Bloc<ListEvent, ListState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieListBloc(this._getNowPlayingMovies) : super(ListEmpty()) {
    on<ListEvent>((event, emit) async {
      emit(ListLoading());
      final result = await _getNowPlayingMovies.execute();

      result.fold(
        (failure) {
          emit(ListError(failure.message));
        },
        (data) {
          emit(ListHasData(data));
        },
      );
    });
  }
}
