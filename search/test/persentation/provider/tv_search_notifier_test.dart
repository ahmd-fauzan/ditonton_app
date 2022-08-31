import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:search/persentation/provider/tv_search_notifier.dart';

import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTV])
void main() {
  late TVSearchNotifier provider;
  late MockSearchTV mockSearchTV;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTV = MockSearchTV();
    provider = TVSearchNotifier(searchTV: mockSearchTV)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTVModel = TV(
    backdropPath: "/68sanslplXryiJWzv0uMuXjJBmB.jpg",
    firstAirDate: "2019-07-25",
    genreIds: [10765, 10759],
    id: 76479,
    name: "The Boys",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "The Boys",
    overview:
        "A group of vigilantes known informally as “The Boys” set out to take down corrupt superheroes with no more than blue-collar grit and a willingness to fight dirty.",
    popularity: 981.984,
    posterPath: "/stTEycfG9928HYGEISBFaG1ngjM.jpg",
    voteAverage: 8.5,
    voteCount: 7090,
  );

  final tTVList = <TV>[tTVModel];
  final tQuery = 'the boys';
  group('search movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchTVSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchTVSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.saerchResult, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTVSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
