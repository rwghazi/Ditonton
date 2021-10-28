import 'package:movie/presentation/bloc/watchlist_page_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/utils/utils.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver2.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    BlocProvider.of<MovieWatchlistPageBloc>(context, listen: false)
      ..add(FetchWatchlistMovies());
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<MovieWatchlistPageBloc>(context, listen: false)
          ..add(FetchWatchlistMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieWatchlistPageBloc, WatchlistPageState>(
          builder: (context, state) {
            if (state is WatchlistPageLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistPageLoaded) {
              final result = state.result;
              if (result.length == 0) {
                return Center(child: Text("Nothing to see here"));
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return MovieCard(movie);
                },
                itemCount: result.length,
              );
            } else if (state is WatchlistPageError) {
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

  @override
  void dispose() {
    routeObserver2.unsubscribe(this);
    super.dispose();
  }
}
