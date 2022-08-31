import 'package:core/styles/text_style.dart';
import 'package:core/utils/routes.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/presentation/provider/movie_provider/movie_list_notifier.dart';
import 'package:core/presentation/provider/tv_series_provider/tv_list_notifier.dart';
import 'package:core/presentation/widgets/movie_widget/movie_list.dart';
import 'package:core/presentation/widgets/tv_widget/tv_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:about/about.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  String dataType = 'Movies';

  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TVListNotifier>(context, listen: false)
      ..fetchOnTheAirTV()
      ..fetchPopularTV()
      ..fetchTopRatedTV());

    Future.microtask(
        () => Provider.of<MovieListNotifier>(context, listen: false)
          ..fetchNowPlayingMovies()
          ..fetchPopularMovies()
          ..fetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('core'),
              accountEmail: Text('core@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                setState(() {
                  dataType = 'Movies';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('TV Series'),
              onTap: () {
                setState(() {
                  dataType = 'TV Series';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Movie Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WATCHLIST_MOVIE_ROUTE);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('TV Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WATCHLIST_TV_ROUTE);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ABOUT_ROUTE);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(dataType),
        actions: [
          IconButton(
            onPressed: () {
              dataType == 'Movies'
                  ? Navigator.pushNamed(context, SEARCH_MOVIE_ROUTE)
                  : Navigator.pushNamed(context, SEARCH_TV_ROUTE);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              dataType == 'Movies'
                  ? Consumer<MovieListNotifier>(
                      builder: (context, data, child) {
                      final state = data.nowPlayingState;
                      if (state == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state == RequestState.Loaded) {
                        return MovieList(data.nowPlayingMovies);
                      } else {
                        return Text('Failed');
                      }
                    })
                  : Consumer<TVListNotifier>(builder: (context, data, child) {
                      final state = data.onTheAirTVState;
                      if (state == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state == RequestState.Loaded) {
                        return TVList(data.onTheAirTV);
                      } else {
                        return Text('Failed');
                      }
                    }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => dataType == 'Movies'
                    ? Navigator.pushNamed(context, POPULAR_MOVIES_ROUTE)
                    : Navigator.pushNamed(context, POPULAR_TV_ROUTE),
              ),
              dataType == 'Movies'
                  ? Consumer<MovieListNotifier>(
                      builder: (context, data, child) {
                      final state = data.popularMoviesState;
                      if (state == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state == RequestState.Loaded) {
                        return MovieList(data.popularMovies);
                      } else {
                        return Text('Failed');
                      }
                    })
                  : Consumer<TVListNotifier>(builder: (context, data, child) {
                      final state = data.popularTVState;
                      if (state == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state == RequestState.Loaded) {
                        return TVList(data.popularTV);
                      } else {
                        return Text('Failed');
                      }
                    }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => dataType == 'Movies'
                    ? Navigator.pushNamed(context, TOP_RATED_MOVIE_ROUTE)
                    : Navigator.pushNamed(context, TOP_RATED_TV_ROUTE),
              ),
              dataType == 'Movies'
                  ? Consumer<MovieListNotifier>(
                      builder: (context, data, child) {
                      final state = data.topRatedMoviesState;
                      if (state == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state == RequestState.Loaded) {
                        return MovieList(data.topRatedMovies);
                      } else {
                        return Text('Failed');
                      }
                    })
                  : Consumer<TVListNotifier>(builder: (context, data, child) {
                      final state = data.topRatedTVState;
                      if (state == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state == RequestState.Loaded) {
                        return TVList(data.topRatedTV);
                      } else {
                        return Text('Failed');
                      }
                    }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
