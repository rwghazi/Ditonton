part of 'nowplaying_movies_bloc.dart';

abstract class NowplayingMoviesState extends Equatable {
  const NowplayingMoviesState();
  
  @override
  List<Object> get props => [];
}

class NowplayingMoviesInitial extends NowplayingMoviesState {}

class NowplayingMoviesLoading extends NowplayingMoviesState {}

class NowplayingMoviesError extends NowplayingMoviesState {
  final String message;
 
  NowplayingMoviesError(this.message);
 
  @override
  List<Object> get props => [message];
}

class NowPlayingMoviesLoaded extends NowplayingMoviesState {
  final List<Movie> result;
 
  NowPlayingMoviesLoaded(this.result);
 
  @override
  List<Object> get props => [result];
}