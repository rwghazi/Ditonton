part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail result;
  final bool isAddedToWatchlist;

  MovieDetailLoaded(this.result, this.isAddedToWatchlist);

  @override
  bool operator ==(Object movie) {
    if (identical(this, movie)) return true;

    return movie is MovieDetailLoaded &&
        movie.result == result &&
        movie.isAddedToWatchlist == isAddedToWatchlist;
  }
}

class MovieWatchlist extends MovieDetailState {
  final String message;
  final MovieDetail movie;
  final bool isAddedToWatchlist;
  const MovieWatchlist(this.message, this.movie, this.isAddedToWatchlist);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovieWatchlist &&
        other.message == message &&
        other.movie == movie &&
        other.isAddedToWatchlist == isAddedToWatchlist;
  }

  @override
  int get hashCode =>
      message.hashCode ^ movie.hashCode ^ isAddedToWatchlist.hashCode;
}