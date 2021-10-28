part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistMovie extends WatchlistMovieEvent {}

class AddToWatchList extends WatchlistMovieEvent {
  final MovieDetail movie;

  AddToWatchList(this.movie);

  @override
  List<Object> get props => [Movie];
}

class RemoveWatchList extends WatchlistMovieEvent {
  final MovieDetail movie;

  RemoveWatchList(this.movie);

  @override
  List<Object> get props => [Movie];
}

class LoadWatchListStatus extends WatchlistMovieEvent {
  final int id;

  LoadWatchListStatus(this.id);

  @override
  List<Object> get props => [id];
}
