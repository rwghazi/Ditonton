import 'package:bloc_test/bloc_test.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
])
void main() {
  late MovieDetailBloc getMovieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    getMovieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
  });

  final tId = 1;

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 1,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  group('Movie Detail BLoC Test', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [loading, loaded] when data is loaded successfully',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Right(tMovieDetail));
          return getMovieDetailBloc;
        },
        act: (bloc) => bloc.add(FetchMovieDetail(tId)),
        expect: () {
          return [MovieDetailLoading(), MovieDetailLoaded(tMovieDetail)];
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [loading, error] when data is failed loaded',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return getMovieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(tId)),
      expect: () {
        return [MovieDetailLoading(), MovieDetailError('Server Failure')];
      },

    );
  });
}
