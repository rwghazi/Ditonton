import 'package:bloc/bloc.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_state.dart';
part 'tv_detail_event.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail _getTvDetail;

  TvDetailBloc(this._getTvDetail) : super(TvDetailInitial());

  @override
  Stream<TvDetailState> mapEventToState(
    TvDetailEvent event,
  ) async* {
    if (event is FetchTvDetail) {
      yield TvDetailLoading();
      final result = await _getTvDetail.execute(event.id);
      yield* result.fold(
        (failure) async* {
          yield TvDetailError(failure.message);
        },
        (data) async* {
          yield TvDetailLoaded(data);
        },
      );
    }
  }
}