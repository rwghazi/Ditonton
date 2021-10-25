import 'package:bloc/bloc.dart';
import 'package:core/domain/movie/entities/movie.dart';
import 'package:core/domain/movie/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc(this.getPopularMovies) : super(PopularMoviesInitial());

  @override
  Stream<PopularMoviesState> mapEventToState(
    PopularMoviesEvent event,
  ) async* {
    if (event is PopularMoviesEvent) {
      yield PopularMoviesLoading();
      final result = await getPopularMovies.execute();

      yield* result.fold((failure) async* {
        yield PopularMoviesError(failure.message);
      }, (movies) async* {
        yield PopularMoviesLoaded(movies);
      });
    }
  }
}
