part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();
  
  @override
  List<Object> get props => [];
}

class TopRatedTvInitial extends TopRatedTvState {}

class TopRatedTvLoading extends TopRatedTvState {}

class TopRatedTvLoaded extends TopRatedTvState {
  final List<Tv> result;

  TopRatedTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TopRatedTvError extends TopRatedTvState {
  final String message;

  TopRatedTvError(this.message);

  @override
  List<Object> get props => [message];
}