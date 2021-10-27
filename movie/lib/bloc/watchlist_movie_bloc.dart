import 'package:bloc/bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  WatchlistMovieBloc({required this.getWatchlistMovies}) : super(WatchlistMovieInitial());
  final GetWatchlistMovies getWatchlistMovies;
  
  @override
  Stream<WatchlistMovieState> mapEventToState(
    WatchlistMovieEvent event,
  ) async*{
    if (event is WatchlistMovieEvent ){
      
      yield WatchlistMoviesLoading();
      final result = await getWatchlistMovies.execute();

      yield* result.fold(
        (failure)async*{
          yield WatchlistMoviesError(failure.message);
        },
        (movies) async*{
          yield WatchlistMoviesLoaded(movies);
        }
      );

    }
  }
}
