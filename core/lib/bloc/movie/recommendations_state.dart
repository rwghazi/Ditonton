part of 'recommendations_bloc.dart';

abstract class RecomendationState extends Equatable {
  const RecomendationState();

  @override
  List<Object> get props => [];
}

class RecomendationInitial extends RecomendationState {
  const RecomendationInitial();
}

class RecomendationLoading extends RecomendationState {
  const RecomendationLoading();
}

class RecomendationError extends RecomendationState {
  final String message;
  const RecomendationError(this.message);

  @override
  bool operator ==(Object movie) {
    if (identical(this, movie)) return true;

    return movie is RecomendationError && movie.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class RecomendationLoaded extends RecomendationState {
  final List<Movie> movies;
  const RecomendationLoaded(this.movies);

  @override
  bool operator ==(Object movie) {
    if (identical(this, movie)) return true;

    return movie is RecomendationLoaded &&
        listEquals(movie.movies, movies);
  }

  @override
  int get hashCode => movies.hashCode;
}
