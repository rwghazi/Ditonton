part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistMovieInitial extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;

  WatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}
class WatchlistMovieLoaded extends WatchlistMovieState {
  final List<Movie> result;

  WatchlistMovieLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistMovieStatus extends WatchlistMovieState {
  final bool result;

  WatchlistMovieStatus(this.result);

  @override
  List<Object> get props => [result];
}
