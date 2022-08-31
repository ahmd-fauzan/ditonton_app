import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:core/domain/usecases/tv_usecase/get_tv_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'get_tv_on_the_air_test.mocks.dart';

void main() {
  late GetTVRecommendations usecase;
  late MockTVRepository mockTVRepository;
  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTVRecommendations(mockTVRepository);
  });

  final tId = 1;
  final tTV = <TV>[];

  test('should get list of tv recommendations from the repository', () async {
    // arrange
    when(mockTVRepository.getRecommendations(tId))
        .thenAnswer((_) async => Right(tTV));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTV));
  });
}
