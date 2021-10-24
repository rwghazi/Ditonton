import 'package:bloc/bloc.dart';
import 'package:core/domain/movie/entities/movie.dart';
import 'package:core/domain/movie/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'nowplaying_movies_event.dart';
part 'nowplaying_movies_state.dart';

class NowplayingMoviesBloc extends Bloc<NowplayingMoviesEvent, NowplayingMoviesState> {
  NowplayingMoviesBloc(this.getNowPlayingMovies) : super(NowplayingMoviesInitial());
  final GetNowPlayingMovies getNowPlayingMovies;

   @override
  Stream<NowplayingMoviesState> mapEventToState(
    NowplayingMoviesEvent event,
  ) async* {
    if (event is FetchNowPlayingMovies) {
      yield NowplayingMoviesLoading();
      final nowPlayingresult = await getNowPlayingMovies.execute();

      yield* nowPlayingresult.fold(
        (failure) async* {
        yield NowplayingMoviesError(failure.message);
      }, (movie) async* {
        yield NowPlayingMoviesLoaded(movie);
      });
    }
  }
}
