import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/recommendations_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_recommendation.dart';
import 'package:tv/utils/failure.dart';

import 'recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late TvRecommendationBloc tvRecomendationBloc;
  late MockGetTvRecommendations mockGetTvRecomendations;

  setUp(() {
    mockGetTvRecomendations = MockGetTvRecommendations();
    tvRecomendationBloc = TvRecommendationBloc(mockGetTvRecomendations);
  });

  final tId = 1;

  final tTv = Tv(
    backdropPath: 'backdropPath',
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    genreIds: [],
    popularity: null,
  );

  final tTvs = <Tv>[tTv];

  blocTest<TvRecommendationBloc, TvRecomendationState>(
    'Should emit [loading, loaded] when data is loaded successfully',
    build: () {
      when(mockGetTvRecomendations.execute(tId))
          .thenAnswer((_) async => Right(tTvs));

      return tvRecomendationBloc;
    },
    act: (bloc) => bloc.add(FetchTvRecomendation(tId)),
    expect: () => [TvRecomendationLoading(), TvRecomendationLoaded(tTvs)],
  );

  blocTest<TvRecommendationBloc, TvRecomendationState>(
    'Should emit [loading, error] when data is failed to load',
    build: () {
      when(mockGetTvRecomendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvRecomendationBloc;
    },
    act: (bloc) => bloc.add(FetchTvRecomendation(tId)),
    expect: () =>
        [TvRecomendationLoading(), TvRecomendationError('Server Failure')],
  );
}
