import 'package:bloc/bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_recommendation.dart';
import 'package:equatable/equatable.dart';

part 'recommendations_state.dart';
part 'recommendations_event.dart';

class TvRecommendationBloc extends Bloc<TvRecomendationsEvent, TvRecomendationState> {
  final GetTvRecommendations _getTvRecommendations;

  TvRecommendationBloc(this._getTvRecommendations)
      : super(TvRecomendationInitial());

  @override
  Stream<TvRecomendationState> mapEventToState(
    TvRecomendationsEvent event,
  ) async* {
    if (event is FetchTvRecomendation) {
      yield TvRecomendationLoading();
      final result = await _getTvRecommendations.execute(event.id);

      yield* result.fold(
        (failure) async* {
          yield TvRecomendationError(failure.message);
        },
        (data) async* {
          yield TvRecomendationLoaded(data);
        },
      );
    }
  }
}