import 'package:movie/bloc/watchlist_movie_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => BlocProvider.of<WatchlistMovieBloc>(context).add(WatchlistMovieEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
          builder: (context, state) {
            if (state is WatchlistMoviesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistMoviesLoaded) {
              final result = state.result;
              if (result.length == 0){
                return Center(child: Text("Nothing to see here"));
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return MovieCard(movie);
                },
                itemCount: result.length,
              );
            } else if (state is WatchlistMoviesError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Text("");
            }
          },
        ),
      ),
    );
  }
}
