part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();
  
  @override
  List<Object> get props => [];
}

class WatchlistMovieInitial extends WatchlistMovieState {}

class WatchlistMoviesLoading extends WatchlistMovieState {}

class WatchlistMoviesLoaded extends WatchlistMovieState {
  final List<Movie> result;

  WatchlistMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistMoviesError extends WatchlistMovieState {
  final String message;

  WatchlistMoviesError(this.message);

  @override
  List<Object> get props => [message];
}