import 'package:bloc/bloc.dart';
import 'package:core/domain/tv/entities/tv.dart';
import 'package:core/domain/tv/usecases/get_popular_tv.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv getPopularTv;

  PopularTvBloc(this.getPopularTv) : super(PopularTvInitial());

  @override
  Stream<PopularTvState> mapEventToState(
    PopularTvEvent event,
  ) async* {
    if (event is PopularTvEvent) {
      yield PopularTvLoading();
      final result = await getPopularTv.execute();

      yield* result.fold((failure) async* {
        yield PopularTvError(failure.message);
      }, (tv) async* {
        yield PopularTvLoaded(tv);
      });
    }
  }
}
