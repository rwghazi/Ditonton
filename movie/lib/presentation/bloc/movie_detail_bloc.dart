import 'package:bloc/bloc.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';

part 'movie_detail_state.dart';
part 'movie_detail_event.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super(MovieDetailInitial());

  @override
  Stream<MovieDetailState> mapEventToState(
    MovieDetailEvent event,
  ) async* {
    if (event is FetchMovieDetail) {
      yield MovieDetailLoading();
      final result = await _getMovieDetail.execute(event.id);
      yield* result.fold(
        (failure) async* {
          yield MovieDetailError(failure.message);
        },
        (data) async* {
          yield MovieDetailLoaded(data);
        },
      );
    }
  }
}