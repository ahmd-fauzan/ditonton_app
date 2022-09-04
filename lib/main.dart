import 'package:core/utils/utils.dart';
import 'package:ditonton/ssl_pinning.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/persentation/bloc/detail_bloc/detail_bloc.dart';
import 'package:movie/persentation/bloc/list_bloc/list_bloc.dart';
import 'package:movie/persentation/bloc/popular_bloc/popular_bloc.dart';
import 'package:movie/persentation/bloc/top_rated_bloc/top_rated_bloc.dart';
import 'package:movie/persentation/bloc/watchlist_bloc/watchlist_bloc.dart';
import 'package:core/persentation/pages/home_movie_page.dart';
import 'package:movie/persentation/pages/movie_detail_page.dart';
import 'package:movie/persentation/pages/popular_movies_page.dart';
import 'package:movie/persentation/pages/top_rated_movies_page.dart';
import 'package:movie/persentation/pages/watchlist_movies_page.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:about/about.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_style.dart';
import 'package:search/persentation/bloc/search_bloc.dart';
import 'package:search/persentation/pages/movie_search_page.dart';
import 'package:search/persentation/pages/tv_search_page.dart';
import 'package:tv_series/presentation/bloc/detail_bloc/detail_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/list_bloc/tv_list_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_bloc/popular_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_bloc/top_rated_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/watchlist_bloc/watchlist_tv_bloc.dart';
import 'package:tv_series/presentation/pages/popular_tv_page.dart';
import 'package:tv_series/presentation/pages/top_rated_tv_page.dart';
import 'package:tv_series/presentation/pages/tv_detail_page.dart';
import 'package:tv_series/presentation/pages/watchlist_tv_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieRecommendationsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<AddMovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvRecommendationsBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case PopularTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTVPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case TopRatedTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTVPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TVDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => TVDetailPage(id: id), settings: settings);
            case MovieSearchPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => MovieSearchPage(),
              );
            case TVSearchPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => TVSearchPage(),
              );
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WatchlistTVPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTVPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
