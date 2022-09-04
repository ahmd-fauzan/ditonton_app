import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_model.dart';
import 'package:tv_series/domain/entities/tv.dart';

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

  test('should be a subclass of TV entity', () async {
    final result = tTVModel.toEntity();
    expect(result, tTV);
  });
}
