import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_tv_on_the_air.dart';
import 'package:tv_series/domain/usecases/get_tv_recommendations.dart';
import 'package:tv_series/presentation/bloc/detail_bloc/detail_tv_bloc.dart';

part 'tv_list_event.dart';
part 'tv_list_state.dart';

class TvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetTVOnTheAir _getTVOnTheAir;

  TvListBloc(this._getTVOnTheAir) : super(TVListEmpty()) {
    on<TvListEvent>((event, emit) async {
      emit(TVListLoading());
      final result = await _getTVOnTheAir.execute();
      print(result);

      result.fold(
        (failure) {
          emit(TVListError(failure.message));
        },
        (data) {
          emit(TVListHasData(data));
        },
      );
    });
  }
}
