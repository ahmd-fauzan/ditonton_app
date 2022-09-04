import 'dart:convert';
import 'dart:io';

import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:tv_series/data/datasources/tv_datasource/tv_remote_data_source.dart';
import 'package:tv_series/data/models/tv_detail_model.dart';
import 'package:tv_series/data/models/tv_response.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TVRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TVRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get currently on the air', () {
    final tTVList =
        TVResponse.fromJson(json.decode(readJson('dummy_data/on_the_air.json')))
            .tvList;

    test('shourd return list of Movie Model when the reason code is 200',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/on_the_air.json'), 200));
      //act
      final result = await dataSource.getTVOnTheAir();
      //assert
      expect(result, equals(tTVList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSource.getTVOnTheAir();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get popular TV', () {
    final tTVList =
        TVResponse.fromJson(json.decode(readJson('dummy_data/popular_tv.json')))
            .tvList;

    test('should return list of tv when response is success (200)', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular_tv.json'), 200));
      //act
      final result = await dataSource.getPopularTV();
      //assert
      expect(result, equals(tTVList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSource.getPopularTV();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated TV', () {
    final tTVList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_tv.json')))
        .tvList;

    test('should return list of top rated tv when response is success (200)',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/top_rated_tv.json'), 200));
      //act
      final result = await dataSource.getTopRatedTV();
      //assert
      expect(result, equals(tTVList));
    });
  });

  group('get detail tv', () {
    final tId = 2;
    final tTVDetail = TVDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));

    test('should return tv detail when the response code is 200', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_detail.json'), 200));
      //act
      final result = await dataSource.getDetailTV(tId);
      //assert
      expect(result, equals(tTVDetail));
    });
  });

  group('tv recommendations', () {
    final tTVList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/tv_recommendations.json')))
        .tvList;
    final tId = 94998;

    test('should return list of tv model when the response code is 200',
        () async {
      //arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_recommendations.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      //act
      final result = await dataSource.getTVRecommendations(tId);
      //assert
      expect(result, equals(tTVList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      //arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSource.getTVRecommendations(tId);
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv', () {
    final tSearchResult = TVResponse.fromJson(
            json.decode(readJson('dummy_data/search_the_boys.json')))
        .tvList;
    final tQuery = 'boys';

    test('should return list of tv when response code is 200', () async {
      //arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/search_the_boys.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      //act
      final result = await dataSource.searchTV(tQuery);
      //assert
      expect(result, tSearchResult);
    });
  });
}
