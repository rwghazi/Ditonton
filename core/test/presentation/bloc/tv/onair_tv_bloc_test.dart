import 'package:bloc_test/bloc_test.dart';
import 'package:core/bloc/tv/on_air_tv_bloc.dart';
import 'package:core/core.dart';
import 'package:core/domain/tv/entities/tv.dart';
import 'package:core/domain/tv/usecases/get_on_air_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'onair_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetOnAirTv,
])
void main() {
  late OnAirTvBloc onAirTvBloc;
  late MockGetOnAirTv mockGetOnAirTv;

  setUp(() {
    mockGetOnAirTv = MockGetOnAirTv();
    onAirTvBloc = OnAirTvBloc(mockGetOnAirTv);
  });

  final tTvList = <Tv>[];

  group('Now Playing Movies BLoC Test', () {
    blocTest<OnAirTvBloc, OnAirTvState>(
        'Should emit [loading, loaded] when data is loaded successfully',
        build: () {
          when(mockGetOnAirTv.execute())
              .thenAnswer((_) async => Right(tTvList));
          return onAirTvBloc;
        },
        act: (bloc) => bloc.add(OnAirTvEvent()),
        expect: () =>
            [OnAirTvLoading(), OnAirTvLoaded(tTvList)],
        verify: (bloc) {
          verify(mockGetOnAirTv.execute());
        });

    blocTest<OnAirTvBloc, OnAirTvState>(
        'Should emit [loading, error] when data is failed to loaded',
        build: () {
          when(mockGetOnAirTv.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return onAirTvBloc;
        },
        act: (bloc) => bloc.add(OnAirTvEvent()),
        expect: () =>
            [OnAirTvLoading(), OnAirTvError('Server Failure')],
        verify: (bloc) {
          verify(mockGetOnAirTv.execute());
        });
  });
}
