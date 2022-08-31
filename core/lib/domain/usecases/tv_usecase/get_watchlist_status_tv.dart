import 'package:core/domain/repositories/tv_repository.dart';

class GetWatchlistStatusTV {
  TVRepository repository;

  GetWatchlistStatusTV(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
