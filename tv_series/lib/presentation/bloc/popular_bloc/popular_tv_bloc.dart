import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tv.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTV _getPopularTV;

  PopularTvBloc(this._getPopularTV) : super(PopularTVEmpty()) {
    on<PopularTvEvent>((event, emit) async {
      emit(PopularTVLoading());
      final result = await _getPopularTV.execute();

      result.fold(
        (failure) {
          emit(PopularTVError(failure.message));
        },
        (data) {
          emit(PopularTVHasData(data));
        },
      );
    });
  }
}
