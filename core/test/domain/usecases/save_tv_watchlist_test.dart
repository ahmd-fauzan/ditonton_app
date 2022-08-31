import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/movie_usecase/save_watchlist.dart';
import 'package:core/domain/usecases/tv_usecase/save_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';
import 'get_tv_on_the_air_test.mocks.dart';

void main() {
  late SaveWatchlistTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = SaveWatchlistTV(mockTVRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockTVRepository.saveWatchlistTV(testTVDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTVDetail);
    // assert
    verify(mockTVRepository.saveWatchlistTV(testTVDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
