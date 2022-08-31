import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/domain/usecases/tv_usecase/get_tv_on_the_air.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_tv_on_the_air_test.mocks.dart';

@GenerateMocks([TVRepository])
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
