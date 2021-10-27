import 'package:bloc_test/bloc_test.dart';
import 'package:movie/bloc/movie_detail_bloc.dart';
import 'package:movie/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc getMovieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    getMovieDetailBloc = MovieDetailBloc(mockGetMovieDetail,
        mockGetWatchlistStatus, mockSaveWatchlist, mockRemoveWatchlist);
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
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return getMovieDetailBloc;
        },
        act: (bloc) => bloc.getDetailMovie(tId),
        expect: () {
          return [isA<MovieDetailLoading>(), isA<MovieDetailLoaded>()];
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [loading, error] when data is failed loaded',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return getMovieDetailBloc;
        },
        act: (bloc) => bloc.getDetailMovie(tId),
        expect: () {
          return [isA<MovieDetailLoading>(), isA<MovieDetailError>()];
        });
  });

  group('Save Movie to Watchlist Test', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [loading, success] when data is succes saved',
        build: () {
          when(mockSaveWatchlist.execute(tMovieDetail))
              .thenAnswer((invocation) async => Right("Success"));
          return getMovieDetailBloc;
        },
        act: (bloc) => bloc.saveToWatchlist(tMovieDetail, true),
        expect: () {
          return [isA<MovieDetailLoading>(), isA<MovieWatchlist>()];
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [loading, error] when data is failed to save',
        build: () {
          when(mockSaveWatchlist.execute(tMovieDetail))
              .thenAnswer((invocation) async => Left(ServerFailure('Server Failure')));
          return getMovieDetailBloc;
        },
        act: (bloc) => bloc.saveToWatchlist(tMovieDetail, true),
        expect: () {
          return [isA<MovieDetailLoading>(), isA<MovieDetailError>()];
        });
  });

  group('Remove Movie from Watchlist Test', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [loading, success] when data is succes removed',
        build: () {
          when(mockRemoveWatchlist.execute(tMovieDetail))
              .thenAnswer((invocation) async => Right("Success"));
          return getMovieDetailBloc;
        },
        act: (bloc) => bloc.removeFromWatchlist(tMovieDetail, true),
        expect: () {
          return [isA<MovieDetailLoading>(), isA<MovieWatchlist>()];
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [loading, error] when data is failed to removed',
        build: () {
          when(mockRemoveWatchlist.execute(tMovieDetail))
              .thenAnswer((invocation) async => Left(ServerFailure('Server Failure')));
          return getMovieDetailBloc;
        },
        act: (bloc) => bloc.removeFromWatchlist(tMovieDetail, true),
        expect: () {
          return [isA<MovieDetailLoading>(), isA<MovieDetailError>()];
        });
  });
}
