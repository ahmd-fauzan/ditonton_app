import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv_entities/tv_detail.dart';
import 'package:core/domain/repositories/tv_repository.dart';

class GetTVDetail {
  TVRepository repository;

  GetTVDetail(this.repository);

  Future<Either<Failure, TVDetail>> execute(int id) {
    return repository.getDetailTV(id);
  }
}
