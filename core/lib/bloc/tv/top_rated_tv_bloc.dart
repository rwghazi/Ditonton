import 'package:bloc/bloc.dart';
import 'package:core/domain/tv/entities/tv.dart';
import 'package:core/domain/tv/usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc
    extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv getTopRatedTv;
  TopRatedTvBloc(this.getTopRatedTv) : super(TopRatedTvInitial());

  @override
  Stream<TopRatedTvState> mapEventToState(
    TopRatedTvEvent event,
  ) async* {
    if (event is TopRatedTvEvent) {
      yield TopRatedTvLoading();
      final result = await getTopRatedTv.execute();

      yield* result.fold((failure) async* {
        yield TopRatedTvError(failure.message);
      }, (tv) async* {
        yield TopRatedTvLoaded(tv);
      });
    }
  }
}
