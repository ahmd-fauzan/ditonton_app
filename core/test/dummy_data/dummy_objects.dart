import 'package:core/data/models/movie_series_model/movie_table.dart';
import 'package:core/data/models/tv_series_model/tv_table.dart';
import 'package:core/domain/entities/movie_entities/genre.dart';
import 'package:core/domain/entities/movie_entities/movie.dart';
import 'package:core/domain/entities/movie_entities/movie_detail.dart';
import 'package:core/domain/entities/tv_entities/createdby.dart';
import 'package:core/domain/entities/tv_entities/network.dart';
import 'package:core/domain/entities/tv_entities/production_country.dart';
import 'package:core/domain/entities/tv_entities/season.dart';
import 'package:core/domain/entities/tv_entities/spoken_language.dart';
import 'package:core/domain/entities/tv_entities/tepisodetoair.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:core/domain/entities/tv_entities/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testTV = TV(
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

final testMovieList = [testMovie];

final testTVList = [testTV];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'movie_posterPath',
  overview: 'movie_overview',
);

final testWatchlistTV = TV.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'tv_posterPath',
  overview: 'tv_overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'movie_posterPath',
  overview: 'movie_overview',
);

final testTVTable = TVTable(
  id: 1,
  name: 'name',
  posterPath: 'tv_posterPath',
  overview: 'tv_overview',
);

final testMovieMap = {
  'movie_id': 1,
  'movie_overview': 'movie_overview',
  'movie_posterPath': 'movie_posterPath',
  'title': 'title',
};

final testTVMap = {
  'tv_id': 1,
  'tv_overview': 'tv_overview',
  'tv_posterPath': 'tv_posterPath',
  'name': 'name',
};

final testTVDetail = TVDetail(
  adult: false,
  backdropPath: "/w0eG4lpAigocIZzJYrYp3cCmyUx.jpg",
  createdBy: [
    CreatedBy(
        id: 19303,
        creditId: "52532e3219c29579400013ab",
        name: "Kevin Smith",
        gender: 2,
        profilePath: "/uxDQ0NTZMnOuAaPa0tQzMFV9dx4.jpg"),
  ],
  episodeRunTime: [132],
  firstAirDate: "2002-12-14",
  genres: [Genre(id: 16, name: "Animation")],
  homepage: "",
  id: 2,
  inProduction: false,
  languages: ["en"],
  lastAirDate: "2002-12-14",
  lastEpisodeToAir: TEpisodeToAir(
    airDate: "2002-12-14",
    episodeNumber: 6,
    id: 1130478,
    name: "The Last Episode Ever",
    overview:
        "The guys' day slacking off at the Quick Stop is derailed by a spoof of \"The Matrix,\" a carnival riot and a trip through the minds of their illustrators.",
    productionCode: "",
    runtime: -1,
    seasonNumber: 1,
    showId: 2,
    stillPath: "/xhbjqZWbMaHKGdvm9M46JN0crRV.jpg",
    voteAverage: 6.5,
    voteCount: 2,
  ),
  name: "Clerks: The Animated Series",
  nextEpisodeToAir: null,
  networks: [
    Network(
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
    Network(
        id: 14,
        name: "Miramax",
        logoPath: "/m6AHu84oZQxvq7n1rsvMNJIAsMu.png",
        originCountry: "US")
  ],
  productionCountries: [
    ProductionCountry(iso31661: "US", name: "United States of America")
  ],
  seasons: [
    Season(
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
    SpokenLanguage(
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
