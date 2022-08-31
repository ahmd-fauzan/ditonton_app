import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_datasource/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_datasource/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_datasource/tv_local_data_source.dart';
import 'package:core/data/datasources/tv_datasource/tv_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/domain/usecases/movie_usecase/get_movie_detail.dart';
import 'package:core/domain/usecases/movie_usecase/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movie_usecase/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movie_usecase/get_popular_movies.dart';
import 'package:core/domain/usecases/movie_usecase/get_top_rated_movies.dart';
import 'package:core/domain/usecases/movie_usecase/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movie_usecase/get_watchlist_status.dart';
import 'package:core/domain/usecases/movie_usecase/remove_watchlist.dart';
import 'package:core/domain/usecases/movie_usecase/save_watchlist.dart';
import 'package:core/domain/usecases/tv_usecase/get_popular_tv.dart';
import 'package:core/domain/usecases/tv_usecase/get_top_rated_tv.dart';
import 'package:core/domain/usecases/tv_usecase/get_tv_detail.dart';
import 'package:core/domain/usecases/tv_usecase/get_tv_on_the_air.dart';
import 'package:core/domain/usecases/tv_usecase/get_tv_recommendations.dart';
import 'package:core/domain/usecases/tv_usecase/get_watchlist_status_tv.dart';
import 'package:core/domain/usecases/tv_usecase/get_watchlist_tv.dart';
import 'package:core/domain/usecases/tv_usecase/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/tv_usecase/save_watchlist_tv.dart';
import 'package:core/presentation/provider/movie_provider/movie_detail_notifier.dart';
import 'package:core/presentation/provider/movie_provider/movie_list_notifier.dart';
import 'package:core/presentation/provider/movie_provider/popular_movies_notifier.dart';
import 'package:core/presentation/provider/movie_provider/top_rated_movies_notifier.dart';
import 'package:core/presentation/provider/movie_provider/watchlist_movie_notifier.dart';
import 'package:core/presentation/provider/tv_series_provider/popular_tv_notifier.dart';
import 'package:core/presentation/provider/tv_series_provider/top_rated_tv_notifier.dart';
import 'package:core/presentation/provider/tv_series_provider/tv_detail_notifier.dart';
import 'package:core/presentation/provider/tv_series_provider/tv_list_notifier.dart';
import 'package:core/presentation/provider/tv_series_provider/watchlist_tv_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:search/persentation/provider/movie_search_notifier.dart';
import 'package:search/persentation/provider/tv_search_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => TVListNotifier(
      getOnTheAirTV: locator(),
      getPopularTV: locator(),
      getTopRatedTV: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => PopularTVNotifier(
      getPopularTV: locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedTVNotifier(
      getTopRatedTV: locator(),
    ),
  );

  locator.registerFactory(
    () => TVDetailNotifier(
      getTVDetail: locator(),
      getTVRecommendations: locator(),
      getWatchlistStatusTV: locator(),
      saveWatchlistTV: locator(),
      removeWatchlistTV: locator(),
    ),
  );

  locator.registerFactory(
    () => TVSearchNotifier(
      searchTV: locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistTVNotifier(
      getWatchlistTV: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetTVOnTheAir(locator()));
  locator.registerLazySingleton(() => GetPopularTV(locator()));
  locator.registerLazySingleton(() => GetTopRatedTV(locator()));
  locator.registerLazySingleton(() => GetTVDetail(locator()));
  locator.registerLazySingleton(() => GetTVRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTV(locator()));
  locator.registerLazySingleton(() => GetWatchlistStatusTV(locator()));
  locator.registerLazySingleton(() => GetWatchlistTV(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTV(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTV(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TVRepository>(
    () => TVRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TVRemoteDataSource>(
      () => TVRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVLocalDataSource>(
      () => TVLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
