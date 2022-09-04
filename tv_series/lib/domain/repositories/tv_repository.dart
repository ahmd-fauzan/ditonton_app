import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';

abstract class TVRepository {
  Future<Either<Failure, List<TV>>> getTvOnTheAir();
  Future<Either<Failure, List<TV>>> getPopularTV();
  Future<Either<Failure, List<TV>>> getTopRatedTV();
  Future<Either<Failure, TVDetail>> getDetailTV(int id);
  Future<Either<Failure, List<TV>>> getRecommendations(int id);
  Future<Either<Failure, List<TV>>> searchTV(String query);
  Future<Either<Failure, List<TV>>> getWatchlistTV();
  Future<Either<Failure, String>> saveWatchlistTV(TVDetail tv);
  Future<Either<Failure, String>> removeWatchlistTV(TVDetail tv);
  Future<bool> isAddedToWatchlist(int id);
}
