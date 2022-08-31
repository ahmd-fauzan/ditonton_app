import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:core/domain/usecases/tv_usecase/get_popular_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'get_tv_on_the_air_test.mocks.dart';

void main() {
  late GetPopularTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetPopularTV(mockTVRepository);
  });

  final tTV = <TV>[];

  group('GetPopularTV', () {
    group('execute', () {
      test(
          'should get list of tv from the repository when execute functions is called',
          () async {
        //arrange
        when(mockTVRepository.getPopularTV())
            .thenAnswer((_) async => Right(tTV));
        //act
        final result = await usecase.execute();
        //assert
        expect(result, Right(tTV));
      });
    });
  });
}
