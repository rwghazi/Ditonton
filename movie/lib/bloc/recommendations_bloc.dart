import 'package:bloc/bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'recommendations_state.dart';

class RecommendationsBloc extends Cubit<RecomendationState> {
  final GetMovieRecommendations getMovieRecommendations;
  RecommendationsBloc(this.getMovieRecommendations)
      : super(RecomendationInitial());

  Future<void> getRecommendation(int id) async {
    emit(RecomendationLoading());
    final result = await getMovieRecommendations.execute(id);
    result.fold((failure) {
      emit(RecomendationError(failure.message));
    }, (result) {
      emit(RecomendationLoaded(result));
    });
  }
}