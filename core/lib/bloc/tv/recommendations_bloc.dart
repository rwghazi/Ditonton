import 'package:bloc/bloc.dart';
import 'package:core/domain/tv/entities/tv.dart';
import 'package:core/domain/tv/usecases/get_tv_recommendation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'recommendations_state.dart';

class TvRecommendationsBloc extends Cubit<TvRecomendationState> {
  final GetTvRecommendations getTvRecommendations;
  TvRecommendationsBloc(this.getTvRecommendations)
      : super(TvRecomendationInitial());

  Future<void> getRecomendation(int id) async {
    emit(TvRecomendationLoading());
    final result = await getTvRecommendations.execute(id);
    result.fold((failure) {
      emit(TvRecomendationError(failure.message));
    }, (result) {
      emit(TvRecomendationLoaded(result));
    });
  }
}