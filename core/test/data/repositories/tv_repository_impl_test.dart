import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:core/data/datasources/tv_datasource/tv_local_data_source.dart';
import 'package:core/data/datasources/tv_datasource/tv_remote_data_source.dart';
import 'package:core/data/models/movie_series_model/genre_model.dart';
import 'package:core/data/models/tv_series_model/createdby_model.dart';
import 'package:core/data/models/tv_series_model/network_model.dart';
import 'package:core/data/models/tv_series_model/production_country_model.dart';
import 'package:core/data/models/tv_series_model/season_model.dart';
import 'package:core/data/models/tv_series_model/spoken_language_model.dart';
import 'package:core/data/models/tv_series_model/tepisodetoair_model.dart';
import 'package:core/data/models/tv_series_model/tv_detail_model.dart';
import 'package:core/data/models/tv_series_model/tv_model.dart';
import 'package:core/data/models/tv_series_model/tv_table.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_repository_impl_test.mocks.dart';

@GenerateMocks([TVRemoteDataSource, TVLocalDataSource])
void main() {
  late TVRepositoryImpl repository;
  late MockTVRemoteDataSource mockTVRemoteDataSource;
  late MockTVLocalDataSource mockTVLocalDataSource;

  setUp(() {
    mockTVRemoteDataSource = MockTVRemoteDataSource();
    mockTVLocalDataSource = MockTVLocalDataSource();
    repository = TVRepositoryImpl(
      remoteDataSource: mockTVRemoteDataSource,
      localDataSource: mockTVLocalDataSource,
    );
  });

  final tTVModel = TVModel(
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

  final tTVModelList = <TVModel>[tTVModel];
  final tTVList = <TV>[tTV];

  group('Now Playing TV', () {
    test(
        'should return remote data when the call to remote data source is succesfull',
        () async {
      //arrange
      when(mockTVRemoteDataSource.getTVOnTheAir())
          .thenAnswer((_) async => tTVModelList);
      //act
      final result = await repository.getTvOnTheAir();
      //assert
      verify(mockTVRemoteDataSource.getTVOnTheAir());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccesfull',
        () async {
      //arrange
      when(mockTVRemoteDataSource.getTVOnTheAir()).thenThrow(ServerException());
      //act
      final result = await repository.getTvOnTheAir();
      //assert
      verify(mockTVRemoteDataSource.getTVOnTheAir());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      //arrange
      when(mockTVRemoteDataSource.getTVOnTheAir())
          .thenThrow(SocketException('Failed to connect to the network'));
      //act
      final result = await repository.getTvOnTheAir();
      //assert
      verify(mockTVRemoteDataSource.getTVOnTheAir());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get popular TV', () {
    test(
        'should return remote data when the call to remote data source is successfull',
        () async {
      //arrange
      when(mockTVRemoteDataSource.getPopularTV())
          .thenAnswer((_) async => tTVModelList);
      //act
      final result = await repository.getPopularTV();
      //assert
      verify(mockTVRemoteDataSource.getPopularTV());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccesfull',
        () async {
      //arrange
      when(mockTVRemoteDataSource.getPopularTV()).thenThrow(ServerException());
      //act
      final result = await repository.getPopularTV();
      //assert
      verify(mockTVRemoteDataSource.getPopularTV());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      //arrange
      when(mockTVRemoteDataSource.getPopularTV())
          .thenThrow(SocketException('Failed to connect to the network'));
      //act
      final result = await repository.getPopularTV();
      //assert
      verify(mockTVRemoteDataSource.getPopularTV());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get top rated tv', () {
    test(
        'should return remote data when the call to remote data source is successfull',
        () async {
      //arrange
      when(mockTVRemoteDataSource.getTopRatedTV())
          .thenAnswer((_) async => tTVModelList);
      //act
      final result = await repository.getTopRatedTV();
      //assert
      verify(mockTVRemoteDataSource.getTopRatedTV());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccesfull',
        () async {
      //arrange
      when(mockTVRemoteDataSource.getTopRatedTV()).thenThrow(ServerException());
      //act
      final result = await repository.getTopRatedTV();
      //assert
      verify(mockTVRemoteDataSource.getTopRatedTV());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      //arrange
      when(mockTVRemoteDataSource.getTopRatedTV())
          .thenThrow(SocketException('Failed to connect to the network'));
      //act
      final result = await repository.getTopRatedTV();
      //assert
      verify(mockTVRemoteDataSource.getTopRatedTV());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Detail TV', () {
    final tId = 2;
    final tTVResponse = TVDetailResponse(
      adult: false,
      backdropPath: "/w0eG4lpAigocIZzJYrYp3cCmyUx.jpg",
      createdBy: [
        CreatedByModel(
            id: 19303,
            creditId: "52532e3219c29579400013ab",
            name: "Kevin Smith",
            gender: 2,
            profilePath: "/uxDQ0NTZMnOuAaPa0tQzMFV9dx4.jpg"),
      ],
      episodeRunTime: [132],
      firstAirDate: "2002-12-14",
      genres: [GenreModel(id: 16, name: "Animation")],
      homepage: "",
      id: 2,
      inProduction: false,
      languages: ["en"],
      lastAirDate: "2002-12-14",
      lastEpisodeToAir: TEpisodeToAirModel(
        airDate: "2002-12-14",
        episodeNumber: 6,
        id: 1130478,
        name: "The Last Episode Ever",
        overview:
            "The guys' day slacking off at the Quick Stop is derailed by a spoof of \"The Matrix,\" a carnival riot and a trip through the minds of their illustrators.",
        productionCode: "",
        runtime: null,
        seasonNumber: 1,
        showId: 2,
        stillPath: "/xhbjqZWbMaHKGdvm9M46JN0crRV.jpg",
        voteAverage: 6.5,
        voteCount: 2,
      ),
      name: "Clerks: The Animated Series",
      nextEpisodeToAir: null,
      networks: [
        NetworkModel(
          id: 2,
          name: "ABC",
          logoPath: "/2uy2ZWcplrSObIyt4x0Y9rkG6qO.png",
          originCountry: "US",
        )
      ],
      numberOfEpisodes: 6,
      numberOfSeasons: 1,
      originCountry: ["US"],
      originalLanguage: "en",
      originalName: "Clerks: The Animated Series",
      overview:
          "Clerks is an American animated sitcom based on Kevin Smith's 1994 comedy of the same name. It was developed for television by Smith, Smith's producing partner Scott Mosier and former Seinfeld writer David Mandel with character designs by Stephen Silver.",
      popularity: 7.676,
      posterPath: "/xunXvzFlkf1GGgMkCySA9CCFumB.jpg",
      productionCompanies: [
        NetworkModel(
            id: 14,
            name: "Miramax",
            logoPath: "/m6AHu84oZQxvq7n1rsvMNJIAsMu.png",
            originCountry: "US")
      ],
      productionCountries: [
        ProductionCountryModel(iso31661: "US", name: "United States of America")
      ],
      seasons: [
        SeasonModel(
          airDate: "",
          episodeCount: 7,
          id: 2328128,
          name: "Specials",
          overview: "",
          posterPath: "",
          seasonNumber: 0,
        ),
      ],
      spokenLanguages: [
        SpokenLanguageModel(
          englishName: "English",
          iso6391: "en",
          name: "English",
        )
      ],
      status: "Ended",
      tagline: "",
      type: "Miniseries",
      voteAverage: 6.871,
      voteCount: 70,
    );

    test(
        'should return tv data when the call to remote data source is successfull',
        () async {
      //arrange
      when(mockTVRemoteDataSource.getDetailTV(tId))
          .thenAnswer((_) async => tTVResponse);
      //act
      final result = await repository.getDetailTV(tId);
      //assert
      verify(mockTVRemoteDataSource.getDetailTV(tId));
      expect(result, equals(Right(testTVDetail)));
    });
  });

  group('Get TV Recommendations', () {
    final tTVList = <TVModel>[];
    final tId = 94997;

    test('should return data tv list when the call is successfull', () async {
      //arrange
      when(mockTVRemoteDataSource.getTVRecommendations(tId))
          .thenAnswer((_) async => tTVList);
      //act
      final result = await repository.getRecommendations(tId);
      //assert
      verify(mockTVRemoteDataSource.getTVRecommendations(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTVList));
    });
  });

  group('Search tv', () {
    final tQuery = 'the boys';

    test('should return tv list when ccall to data source is successfull',
        () async {
      //arrange
      when(mockTVRemoteDataSource.searchTV(tQuery))
          .thenAnswer((_) async => tTVModelList);
      //act
      final result = await repository.searchTV(tQuery);
      //assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockTVLocalDataSource
              .insertWatchlistTV(TVTable.fromEntity(testTVDetail)))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlistTV(testTVDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockTVLocalDataSource
              .insertWatchlistTV(TVTable.fromEntity(testTVDetail)))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlistTV(testTVDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockTVLocalDataSource
              .removeWatchlistTV(TVTable.fromEntity(testTVDetail)))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlistTV(testTVDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockTVLocalDataSource
              .removeWatchlistTV(TVTable.fromEntity(testTVDetail)))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlistTV(testTVDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockTVLocalDataSource.getByIdTV(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist movies', () {
    test('should return list of Movies', () async {
      // arrange
      when(mockTVLocalDataSource.getWatchlistTV())
          .thenAnswer((_) async => [testTVTable]);
      // act
      final result = await repository.getWatchlistTV();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTV]);
    });
  });
}
