import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:core/domain/repositories/tv_repository.dart';

class GetWatchlistTV {
  final TVRepository repository;

  GetWatchlistTV(this.repository);

  Future<Either<Failure, List<TV>>> execute() async {
    return repository.getWatchlistTV();
  }
}
