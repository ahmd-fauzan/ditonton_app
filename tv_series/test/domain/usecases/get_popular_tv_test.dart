import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tv.dart';

import '../../helpers/test_helper.mocks.dart';

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
