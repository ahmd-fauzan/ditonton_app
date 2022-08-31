import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:core/domain/repositories/tv_repository.dart';

class GetTVOnTheAir {
  final TVRepository repository;

  GetTVOnTheAir(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getTvOnTheAir();
  }
}
