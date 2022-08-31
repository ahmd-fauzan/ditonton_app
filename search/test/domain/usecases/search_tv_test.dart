import 'package:core/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:mockito/annotations.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'search_tv_test.mocks.dart';

@GenerateMocks([TVRepository])
void main() {
  late SearchTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = SearchTV(mockTVRepository);
  });

  final tTV = <TV>[];
  final tQuery = 'The boys';

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTVRepository.searchTV(tQuery)).thenAnswer((_) async => Right(tTV));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTV));
  });
}
