part of 'recommendations_bloc.dart';

abstract class TvRecomendationState extends Equatable {
  const TvRecomendationState();

  @override
  List<Object> get props => [];
}

class TvRecomendationInitial extends TvRecomendationState {}

class TvRecomendationLoading extends TvRecomendationState {}

class TvRecomendationError extends TvRecomendationState {
  final String message;
  const TvRecomendationError(this.message);

  @override
  List<Object> get props => [message];
}

class TvRecomendationLoaded extends TvRecomendationState {
  final List<Tv> tvs;
  const TvRecomendationLoaded(this.tvs);

  @override
  List<Object> get props => [tvs];
}
