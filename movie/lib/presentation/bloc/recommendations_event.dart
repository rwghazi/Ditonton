part of 'recommendations_bloc.dart';

abstract class MovieRecommendationsEvent extends Equatable {
  const MovieRecommendationsEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieRecommendation extends MovieRecommendationsEvent {
  final int id;

  FetchMovieRecommendation(this.id);

  @override
  List<Object> get props => [id];
}