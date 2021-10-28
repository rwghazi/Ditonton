part of 'recommendations_bloc.dart';

abstract class TvRecomendationsEvent extends Equatable{
  const TvRecomendationsEvent();

  @override
  List<Object> get props => [];
}

class FetchTvRecomendation extends TvRecomendationsEvent {
  final int id;

  FetchTvRecomendation(this.id);

  @override
  List<Object> get props => [id];
}