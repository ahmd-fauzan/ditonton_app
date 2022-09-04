import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_recommendations.dart';

part 'detail_tv_event.dart';
part 'detail_tv_state.dart';

class DetailTvBloc extends Bloc<DetailTvEvent, DetailTvState> {
  final GetTVDetail _getTVDetail;

  DetailTvBloc(this._getTVDetail) : super(DetailTVEmpty()) {
    on<GetDetailTV>((event, emit) async {
      final int id = event.tvId;
      emit(DetailTVLoading());
      final result = await _getTVDetail.execute(id);

      result.fold(
        (failure) {
          emit(DetailTVError(failure.message));
        },
        (data) {
          emit(DetailTVHasData(data));
        },
      );
    });
  }
}

class TvRecommendationsBloc extends Bloc<DetailTvEvent, DetailTvState> {
  final GetTVRecommendations _getTVRecommendations;

  TvRecommendationsBloc(this._getTVRecommendations) : super(DetailTVEmpty()) {
    on<FetchTvRecommendations>(
      (event, emit) async {
        final id = event.tvId;
        emit(DetailTVLoading());
        final result = await _getTVRecommendations.execute(id);

        result.fold(
          (failure) {
            emit(DetailTVError(failure.message));
          },
          (data) {
            emit(TvRecommendationsHasData(data));
          },
        );
      },
    );
  }
}
