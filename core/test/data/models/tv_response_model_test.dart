import 'dart:convert';

import 'package:core/data/models/tv_series_model/tv_model.dart';
import 'package:core/data/models/tv_series_model/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
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

  final tTVResponseModel = TVResponse(tvList: <TVModel>[tTVModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/on_the_air.json'));
      //act
      final result = TVResponse.fromJson(jsonMap);
      //assert
      expect(result, tTVResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      //arrange
      //act
      final result = tTVResponseModel.toJson();
      //assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/9GvhICFMiRQA82vS6ydkXxeEkrd.jpg",
            "first_air_date": "2022-08-18",
            "genre_ids": [35, 10759, 10765],
            "id": 92783,
            "name": "She-Hulk: Attorney at Law",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "She-Hulk: Attorney at Law",
            "overview":
                "Jennifer Walters navigates the complicated life of a single, 30-something attorney who also happens to be a green 6-foot-7-inch superpowered hulk.",
            "popularity": 4413.772,
            "poster_path": "/qhRex189iu6Cs0dV7ahbuBaRgeK.jpg",
            "vote_average": 7.5,
            "vote_count": 266
          }
        ],
      };

      expect(result, expectedJsonMap);
    });
  });
}
