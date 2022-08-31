import 'package:core/utils/utils.dart';
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/presentation/pages/movies_page/movie_detail_page.dart';
import 'package:core/presentation/pages/movies_page/popular_movies_page.dart';
import 'package:core/presentation/pages/movies_page/top_rated_movies_page.dart';
import 'package:core/presentation/pages/movies_page/watchlist_movies_page.dart';
import 'package:core/presentation/pages/tv_series_page/popular_tv_page.dart';
import 'package:core/presentation/pages/tv_series_page/top_rated_tv_page.dart';
import 'package:core/presentation/pages/tv_series_page/tv_detail_page.dart';
import 'package:core/presentation/pages/tv_series_page/watchlist_tv_page.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:about/about.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_style.dart';
import 'package:search/persentation/pages/movie_search_page.dart';
import 'package:search/persentation/pages/tv_search_page.dart';
import 'package:search/persentation/provider/movie_search_notifier.dart';
import 'package:search/persentation/provider/tv_search_notifier.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTVNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTVNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTVNotifier>(),
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
