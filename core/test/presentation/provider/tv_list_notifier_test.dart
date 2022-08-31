import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:core/domain/usecases/tv_usecase/get_popular_tv.dart';
import 'package:core/domain/usecases/tv_usecase/get_top_rated_tv.dart';
import 'package:core/domain/usecases/tv_usecase/get_tv_on_the_air.dart';
import 'package:core/presentation/provider/tv_series_provider/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetTVOnTheAir, GetPopularTV, GetTopRatedTV])
void main() {
  late TVListNotifier provider;
  late MockGetTVOnTheAir mockGetTVOnTheAir;
  late MockGetPopularTV mockGetPopularTV;
  late MockGetTopRatedTV mockGetTopRatedTV;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTVOnTheAir = MockGetTVOnTheAir();
    mockGetPopularTV = MockGetPopularTV();
    mockGetTopRatedTV = MockGetTopRatedTV();
    provider = TVListNotifier(
      getOnTheAirTV: mockGetTVOnTheAir,
      getPopularTV: mockGetPopularTV,
      getTopRatedTV: mockGetTopRatedTV,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTV = TV(
    backdropPath: "/9GvhICFMiRQA82vS6ydkXxeEkrd.jpg",
    firstAirDate: "2022-08-18",
    genreIds: [35, 10759, 10765],
    id: 92783,
    name: "She-Hulk: Attorney at Law",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "She-Hulk: Attorney at Law",
    overview:
        "Jennifer Walters navigates the complicated life of a single, 30-something attorney who also happens to be a green 6-foot-7-inch superpowered hulk.",
    popularity: 4413.772,
    posterPath: "/qhRex189iu6Cs0dV7ahbuBaRgeK.jpg",
    voteAverage: 7.5,
    voteCount: 266,
  );

  final tTVList = <TV>[tTV];

  group('on the air', () {
    test('initialisasiState should be Empty', () {
      expect(provider.onTheAirTVState, equals(RequestState.Empty));
    });

    test('should get data from the use case', () {
      //arrange
      when(mockGetTVOnTheAir.execute()).thenAnswer((_) async => Right(tTVList));
      //act
      provider.fetchOnTheAirTV();
      //assert
      verify(mockGetTVOnTheAir.execute());
    });

    test('should change state to loading when usecase is called', () {
      //arrange
      when(mockGetTVOnTheAir.execute()).thenAnswer((_) async => Right(tTVList));
      //act
      provider.fetchOnTheAirTV();
      //assert
      expect(provider.onTheAirTVState, RequestState.Loading);
    });

    test('should change tv when data is gotten successfuly', () async {
      //arrange
      when(mockGetTVOnTheAir.execute()).thenAnswer((_) async => Right(tTVList));
      //act
      await provider.fetchOnTheAirTV();
      //assert
      expect(provider.onTheAirTVState, RequestState.Loaded);
      expect(provider.onTheAirTV, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccesful', () async {
      //arrange
      when(mockGetTVOnTheAir.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      //act
      await provider.fetchOnTheAirTV();
      //assert
      expect(provider.onTheAirTVState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv', () {
    test('should get data from the use case', () {
      //arrange
      when(mockGetPopularTV.execute()).thenAnswer((_) async => Right(tTVList));
      //act
      provider.fetchPopularTV();
      //assert
      verify(mockGetPopularTV.execute());
    });

    test('should change state to loading when usecase is called', () {
      //arrange
      when(mockGetPopularTV.execute()).thenAnswer((_) async => Right(tTVList));
      //act
      provider.fetchPopularTV();
      //assert
      expect(provider.popularTVState, RequestState.Loading);
    });

    test('should change tv when data is gotten successfuly', () async {
      //arrange
      when(mockGetPopularTV.execute()).thenAnswer((_) async => Right(tTVList));
      //act
      await provider.fetchPopularTV();
      //assert
      expect(provider.popularTVState, RequestState.Loaded);
      expect(provider.popularTV, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccesful', () async {
      //arrange
      when(mockGetPopularTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      //act
      await provider.fetchPopularTV();
      //assert
      expect(provider.popularTVState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated', () {
    test('should get data from the use case', () {
      //arrange
      when(mockGetTopRatedTV.execute()).thenAnswer((_) async => Right(tTVList));
      //act
      provider.fetchTopRatedTV();
      //assert
      verify(mockGetTopRatedTV.execute());
    });

    test('should change state to loading when usecase is called', () {
      //arrange
      when(mockGetTopRatedTV.execute()).thenAnswer((_) async => Right(tTVList));
      //act
      provider.fetchTopRatedTV();
      //assert
      expect(provider.topRatedTVState, RequestState.Loading);
    });

    test('should change tv when data is gotten successfuly', () async {
      //arrange
      when(mockGetTopRatedTV.execute()).thenAnswer((_) async => Right(tTVList));
      //act
      await provider.fetchTopRatedTV();
      //assert
      expect(provider.topRatedTVState, RequestState.Loaded);
      expect(provider.topRatedTV, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccesful', () async {
      //arrange
      when(mockGetTopRatedTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      //act
      await provider.fetchTopRatedTV();
      //assert
      expect(provider.topRatedTVState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
