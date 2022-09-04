import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_tv_on_the_air.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVOnTheAir usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTVOnTheAir(mockTVRepository);
  });

  final tTV = <TV>[];

  test('should get list of tv on the air from repository', () async {
    //arrange
    when(mockTVRepository.getTvOnTheAir()).thenAnswer((_) async => Right(tTV));
    //act
    final result = await usecase.execute();
    //assert
    expect(result, Right(tTV));
  });
}
