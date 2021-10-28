part of 'recommendations_bloc.dart';

abstract class RecommendationState extends Equatable {
  const RecommendationState();

  @override
  List<Object> get props => [];
}

class RecommendationInitial extends RecommendationState {
  const RecommendationInitial();
}

class RecommendationLoading extends RecommendationState {
  const RecommendationLoading();
}

class RecommendationError extends RecommendationState {
  final String message;
  const RecommendationError(this.message);

   @override
  List<Object> get props => [message];
}

class RecommendationLoaded extends RecommendationState {
  final List<Movie> movies;
  const RecommendationLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}
