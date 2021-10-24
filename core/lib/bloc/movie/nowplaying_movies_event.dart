part of 'nowplaying_movies_bloc.dart';

abstract class NowplayingMoviesEvent extends Equatable {
  const NowplayingMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingMovies extends NowplayingMoviesEvent{
  @override
  List<Object> get props => [];
}
