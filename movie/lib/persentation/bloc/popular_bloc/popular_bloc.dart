import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class MoviePopularBloc extends Bloc<PopularEvent, PopularState> {
  final GetPopularMovies _getPopularMovies;

  MoviePopularBloc(this._getPopularMovies) : super(PopularEmpty()) {
    on<PopularEvent>((event, emit) async {
      emit(PopularLoading());

      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(PopularError(failure.message));
        },
        (data) {
          emit(PopularHasData(data));
        },
      );
    });
  }
}
