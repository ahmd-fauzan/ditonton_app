import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/repositories/tv_repository.dart';

class GetTVRecommendations {
  final TVRepository repository;

  GetTVRecommendations(this.repository);

  Future<Either<Failure, List<TV>>> execute(int id) {
    return repository.getRecommendations(id);
  }
}
