import 'package:core/styles/text_style.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/persentation/bloc/list_bloc/list_bloc.dart';
import 'package:movie/persentation/bloc/popular_bloc/popular_bloc.dart';
import 'package:movie/persentation/bloc/top_rated_bloc/top_rated_bloc.dart';
import 'package:movie/persentation/widgets/movie_list.dart';
import 'package:tv_series/presentation/bloc/list_bloc/tv_list_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_bloc/popular_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_bloc/top_rated_tv_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_list.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  String dataType = 'Movies';

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<MovieListBloc>().add(GetMovieList()));
    Future.microtask(
        () => context.read<MoviePopularBloc>().add(GetPopularMovie()));
    Future.microtask(
        () => context.read<MovieTopRatedBloc>().add(GetTopRatedMovie()));
    Future.microtask(() => context.read<TvListBloc>().add(FetchTvList()));
    Future.microtask(() => context.read<PopularTvBloc>().add(FetchPopularTV()));
    Future.microtask(() => context.read<TopRatedTvBloc>().add(FetchTopRated()));
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
                  ? BlocBuilder<MovieListBloc, ListState>(
                      builder: (context, state) {
                        if (state is ListLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ListHasData) {
                          return MovieList(state.result);
                        } else if (state is ListError) {
                          return Expanded(
                            child: Center(
                              child: Text(state.message),
                            ),
                          );
                        }
                        return Container();
                      },
                    )
                  : BlocBuilder<TvListBloc, TvListState>(
                      builder: (context, state) {
                        if (state is TVListLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is TVListHasData) {
                          return TVList(state.result);
                        } else if (state is TVListError) {
                          return Expanded(
                            child: Center(
                              child: Text(state.message),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => dataType == 'Movies'
                    ? Navigator.pushNamed(context, POPULAR_MOVIES_ROUTE)
                    : Navigator.pushNamed(context, POPULAR_TV_ROUTE),
              ),
              dataType == 'Movies'
                  ? BlocBuilder<MoviePopularBloc, PopularState>(
                      builder: (context, state) {
                        if (state is PopularLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is PopularHasData) {
                          return MovieList(state.result);
                        } else if (state is PopularError) {
                          return Expanded(
                            child: Center(
                              child: Text(state.message),
                            ),
                          );
                        }
                        return Container();
                      },
                    )
                  : BlocBuilder<PopularTvBloc, PopularTvState>(
                      builder: (context, state) {
                      if (state is PopularTVLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is PopularTVHasData) {
                        return TVList(state.result);
                      } else if (state is PopularTVError) {
                        return Expanded(
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      }
                      return Container();
                    }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => dataType == 'Movies'
                    ? Navigator.pushNamed(context, TOP_RATED_MOVIE_ROUTE)
                    : Navigator.pushNamed(context, TOP_RATED_TV_ROUTE),
              ),
              dataType == 'Movies'
                  ? BlocBuilder<MovieTopRatedBloc, TopRatedState>(
                      builder: (context, state) {
                      if (state is TopRatedLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TopRatedHasData) {
                        return MovieList(state.result);
                      } else if (state is TopRatedError) {
                        return Expanded(
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      }
                      return Container();
                    })
                  : BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
                      builder: (context, state) {
                      if (state is TopRatedTVLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TopRatedTVHasData) {
                        return TVList(state.result);
                      } else if (state is TopRatedTVError) {
                        return Expanded(
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      }
                      return Container();
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
