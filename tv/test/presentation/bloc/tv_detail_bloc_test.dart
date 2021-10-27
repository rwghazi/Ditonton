import 'package:bloc_test/bloc_test.dart';
import 'package:tv/bloc/tv_detail_bloc.dart';
import 'package:tv/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_watchlist_status.dart';
import 'package:tv/domain/usecases/remove_watchlist.dart';
import 'package:tv/domain/usecases/save_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetWatchListTvStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late TvDetailBloc getTvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetWatchListTvStatus mockGetWatchlistTvStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetWatchlistTvStatus = MockGetWatchListTvStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    getTvDetailBloc = TvDetailBloc(mockGetTvDetail, mockGetWatchlistTvStatus,
        mockSaveWatchlist, mockRemoveWatchlist);
  });

  final tId = 1;

  final tTvDetail = TvDetail(
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

  group('Tv Detail BLoC Test', () {
    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [loading, loaded] when data is loaded successfully',
        build: () {
          when(mockGetTvDetail.execute(tId))
              .thenAnswer((_) async => Right(testTvDetail));
          when(mockGetWatchlistTvStatus.execute(tId))
              .thenAnswer((_) async => true);
          return getTvDetailBloc;
        },
        act: (bloc) => bloc.getDetailTv(tId),
        expect: () {
          return [isA<TvDetailLoading>(), isA<TvDetailLoaded>()];
        });

    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [loading, error] when data is failed loaded',
        build: () {
          when(mockGetTvDetail.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure("error")));
          when(mockGetWatchlistTvStatus.execute(tId))
              .thenAnswer((_) async => true);
          return getTvDetailBloc;
        },
        act: (bloc) => bloc.getDetailTv(tId),
        expect: () {
          return [isA<TvDetailLoading>(), isA<TvDetailError>()];
        });
  });

  group('Save Tv to Watchlist Test', () {
    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [loading, success] when data is succes saved',
        build: () {
          when(mockSaveWatchlist.execute(tTvDetail))
              .thenAnswer((invocation) async => Right("Success"));
          return getTvDetailBloc;
        },
        act: (bloc) => bloc.saveToWatchlist(tTvDetail, true),
        expect: () {
          return [isA<TvDetailLoading>(), isA<TvWatchlist>()];
        });

    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [loading, error] when data is failed to save',
        build: () {
          when(mockSaveWatchlist.execute(tTvDetail))
              .thenAnswer((invocation) async => Left(ConnectionFailure("")));
          return getTvDetailBloc;
        },
        act: (bloc) => bloc.saveToWatchlist(tTvDetail, true),
        expect: () {
          return [isA<TvDetailLoading>(), isA<TvDetailError>()];
        });
  });

  group('Remove Tv from Watchlist Test', () {
    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [loading, success] when data is succes removed',
        build: () {
          when(mockRemoveWatchlist.execute(tTvDetail))
              .thenAnswer((invocation) async => Right("Success"));
          return getTvDetailBloc;
        },
        act: (bloc) => bloc.removeFromWatchlist(tTvDetail, true),
        expect: () {
          return [isA<TvDetailLoading>(), isA<TvWatchlist>()];
        });

    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [loading, error] when data is failed to removed',
        build: () {
          when(mockRemoveWatchlist.execute(tTvDetail))
              .thenAnswer((invocation) async => Left(ServerFailure("")));
          return getTvDetailBloc;
        },
        act: (bloc) => bloc.removeFromWatchlist(tTvDetail, true),
        expect: () {
          return [isA<TvDetailLoading>(), isA<TvDetailError>()];
        });
  });
}
