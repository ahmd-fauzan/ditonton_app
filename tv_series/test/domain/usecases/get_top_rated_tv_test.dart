import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTopRatedTV(mockTVRepository);
  });

  final tTV = <TV>[];

  group('GetTopRatedTV', () {
    test(
        'should get list of tv from the repository when execute function is called',
        () async {
      //arrange
      when(mockTVRepository.getTopRatedTV())
          .thenAnswer((_) async => Right(tTV));
      //act
      final result = await usecase.execute();
      //assert
      expect(result, Right(tTV));
    });
  });
}
