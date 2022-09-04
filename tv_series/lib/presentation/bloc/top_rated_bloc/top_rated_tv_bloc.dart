import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTV _getTopRatedTV;

  TopRatedTvBloc(this._getTopRatedTV) : super(TopRatedTVEmpty()) {
    on<TopRatedTvEvent>((event, emit) async {
      emit(TopRatedTVLoading());
      final result = await _getTopRatedTV.execute();

      result.fold(
        (failure) {
          emit(TopRatedTVError(failure.message));
        },
        (data) {
          emit(TopRatedTVHasData(data));
        },
      );
    });
  }
}
