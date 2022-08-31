import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tv_usecase/get_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'get_tv_on_the_air_test.mocks.dart';

void main() {
  late GetTVDetail usecase;
  late MockTVRepository mockTVRepository;
  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTVDetail(mockTVRepository);
  });

  final tId = 1;

  test('should get tv detail from the repository', () async {
    // arrange
    when(mockTVRepository.getDetailTV(tId))
        .thenAnswer((_) async => Right(testTVDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTVDetail));
  });
}
