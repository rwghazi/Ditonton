import 'package:bloc_test/bloc_test.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc.dart';
import 'package:movie/movie.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_bloc_test.mocks.dart';


@GenerateMocks([
  GetPopularMovies,
])
void main() {
  late PopularMoviesBloc popularMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);
  });

  final tMovieList = <Movie>[];

  group('Now Playing Movies BLoC Test', () {
    blocTest<PopularMoviesBloc, PopularMoviesState>(
        'Should emit [loading, loaded] when data is loaded successfully',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return popularMoviesBloc;
        },
        act: (bloc) => bloc.add(PopularMoviesEvent()),
        expect: () =>
            [PopularMoviesLoading(), PopularMoviesLoaded(tMovieList)],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        });

    blocTest<PopularMoviesBloc, PopularMoviesState>(
        'Should emit [loading, error] when data is failed to loaded',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return popularMoviesBloc;
        },
        act: (bloc) => bloc.add(PopularMoviesEvent()),
        expect: () =>
            [PopularMoviesLoading(), PopularMoviesError('Server Failure')],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        });
  });
}
