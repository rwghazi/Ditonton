import 'package:bloc_test/bloc_test.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:tv/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
])
void main() {
  late TvDetailBloc getTvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    getTvDetailBloc = TvDetailBloc(mockGetTvDetail);
  });

  final tId = 1;

  final tMovieDetail = TvDetail(
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    voteAverage: 1,
    voteCount: 1,
  );

  group('Movie Detail BLoC Test', () {
    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [loading, loaded] when data is loaded successfully',
        build: () {
          when(mockGetTvDetail.execute(tId))
              .thenAnswer((_) async => Right(tMovieDetail));
          return getTvDetailBloc;
        },
        act: (bloc) => bloc.add(FetchTvDetail(tId)),
        expect: () {
          return [TvDetailLoading(), TvDetailLoaded(tMovieDetail)];
        });

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [loading, error] when data is failed to loaded',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return getTvDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvDetail(tId)),
      expect: () {
        return [TvDetailLoading(), TvDetailError('Server Failure')];
      },
    );
  });
}
