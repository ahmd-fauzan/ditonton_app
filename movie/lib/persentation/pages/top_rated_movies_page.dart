import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/persentation/bloc/top_rated_bloc/top_rated_bloc.dart';
import 'package:movie/persentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<MovieTopRatedBloc>().add(GetTopRatedMovie()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieTopRatedBloc, TopRatedState>(
          builder: (context, state) {
            if (state is TopRatedLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie);
                },
                itemCount: state.result.length,
              );
            } else if (state is TopRatedError) {
              return Center(
                key: Key('error_message'),
                child: Expanded(
                  child: Center(
                    child: Text(state.message),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
