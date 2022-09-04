import 'package:ditonton/ssl_pinning.dart';
import 'package:movie/data/datasources/db/movie_database_helper.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/persentation/bloc/detail_bloc/detail_bloc.dart';
import 'package:tv_series/data/datasources/db/tv_database_helper.dart';
import 'package:tv_series/data/datasources/tv_datasource/tv_local_data_source.dart';
import 'package:tv_series/data/datasources/tv_datasource/tv_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:tv_series/data/repositories/tv_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/persentation/bloc/list_bloc/list_bloc.dart';
import 'package:movie/persentation/bloc/popular_bloc/popular_bloc.dart';
import 'package:movie/persentation/bloc/top_rated_bloc/top_rated_bloc.dart';
import 'package:movie/persentation/bloc/watchlist_bloc/watchlist_bloc.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:search/persentation/bloc/search_bloc.dart';
import 'package:tv_series/domain/repositories/tv_repository.dart';
import 'package:tv_series/domain/usecases/get_tv_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_on_the_air.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tv.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv.dart';
import 'package:tv_series/domain/usecases/get_tv_recommendations.dart';
import 'package:tv_series/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv_series/domain/usecases/save_watchlist_tv.dart';
import 'package:tv_series/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv_series/presentation/bloc/detail_bloc/detail_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/list_bloc/tv_list_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_bloc/popular_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_bloc/top_rated_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/watchlist_bloc/watchlist_tv_bloc.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(
    () => MovieListBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MoviePopularBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieTopRatedBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieWatchlistBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieDetailBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieRecommendationsBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => AddMovieWatchlistBloc(
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieSearchBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TVSearchBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvListBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => PopularTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistTvBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => DetailTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvRecommendationsBloc(
      locator(),
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
  locator.registerLazySingleton(() => SaveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveMovieWatchlist(locator()));
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
  locator
      .registerLazySingleton<MovieDatabaseHelper>(() => MovieDatabaseHelper());
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
