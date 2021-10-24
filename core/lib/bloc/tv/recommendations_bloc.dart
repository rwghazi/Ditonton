import 'package:bloc/bloc.dart';
import 'package:core/domain/tv/entities/tv.dart';
import 'package:core/domain/tv/usecases/get_tv_recommendation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'recommendations_state.dart';

class TvRecommendationsBloc extends Cubit<RecomendationState> {
  final GetTvRecommendations getTvRecommendations;
  TvRecommendationsBloc(this.getTvRecommendations)
      : super(RecomendationInitial());

  Future<void> getRecomendation(int id) async {
    emit(RecomendationLoading());
    final result = await getTvRecommendations.execute(id);
    result.fold((failure) {
      emit(RecomendationError(failure.message));
    }, (result) {
      emit(RecomendationLoaded(result));
    });
  }
}