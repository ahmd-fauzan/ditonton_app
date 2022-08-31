import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv_entities/tv_detail.dart';
import 'package:core/domain/repositories/tv_repository.dart';

class RemoveWatchlistTV {
  TVRepository repository;

  RemoveWatchlistTV(this.repository);

  Future<Either<Failure, String>> execute(TVDetail tv) async {
    return repository.removeWatchlistTV(tv);
  }
}
