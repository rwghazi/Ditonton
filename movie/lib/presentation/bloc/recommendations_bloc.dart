import 'package:bloc/bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'recommendations_state.dart';
part 'recommendations_event.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationsEvent, RecommendationState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecommendationBloc(this._getMovieRecommendations)
      : super(RecommendationInitial());

  @override
  Stream<RecommendationState> mapEventToState(
    MovieRecommendationsEvent event,
  ) async* {
    if (event is FetchMovieRecommendation) {
      yield RecommendationLoading();
      final result = await _getMovieRecommendations.execute(event.id);

      yield* result.fold(
        (failure) async* {
          yield RecommendationError(failure.message);
        },
        (data) async* {
          yield RecommendationLoaded(data);
        },
      );
    }
  }
}
