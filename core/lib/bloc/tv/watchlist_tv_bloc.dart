import 'package:bloc/bloc.dart';
import 'package:core/domain/tv/entities/tv.dart';
import 'package:core/domain/tv/usecases/get_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  WatchlistTvBloc({required this.getWatchlistTv})
      : super(WatchlistTvInitial());
  final GetWatchlistTv getWatchlistTv;

  @override
  Stream<WatchlistTvState> mapEventToState(
    WatchlistTvEvent event,
  ) async* {
    if (event is WatchlistTvEvent) {
      yield WatchlistTvLoading();
      final result = await getWatchlistTv.execute();

      yield* result.fold((failure) async* {
        yield WatchlistTvError(failure.message);
      }, (tv) async* {
        yield WatchlistTvLoaded(tv);
      });
    }
  }
}
