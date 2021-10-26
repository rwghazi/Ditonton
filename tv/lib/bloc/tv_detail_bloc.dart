import 'package:bloc/bloc.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_watchlist_status.dart';
import 'package:tv/domain/usecases/remove_watchlist.dart';
import 'package:tv/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_state.dart';

class TvDetailBloc extends Cubit<TvDetailState> {
  final GetTvDetail getTvDetail;
  final GetWatchListTvStatus watchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  TvDetailBloc(this.getTvDetail, this.watchListStatus, this.saveWatchlist,
      this.removeWatchlist)
      : super(TvDetailInitial());

  Future<void> getDetailTv(int id) async {
    emit(TvDetailLoading());
    final result = await getTvDetail.execute(id);
    final isAddedToWatchlist = await watchListStatus.execute(id);
    result.fold((failure) {
      emit(TvDetailError(failure.message));
    }, (result) {
      emit(TvDetailLoaded(result, isAddedToWatchlist));
    });
  }

  Future<void> saveToWatchlist(
      TvDetail tv, bool isAddedToWatchlist) async {
    emit(TvDetailLoading());
    final result = await saveWatchlist.execute(tv);
    result.fold((failure) {
      emit(TvDetailError(failure.message));
    }, (result) {
      emit(TvWatchlist(result, tv, isAddedToWatchlist));
    });
  }

  Future<void> removeFromWatchlist(
      TvDetail data, bool isAddedToWatchlist) async {
    emit(TvDetailLoading());
    final result = await removeWatchlist.execute(data);
    result.fold((failure) {
      emit(TvDetailError(failure.message));
    }, (result) {
      emit(TvWatchlist(result, data, isAddedToWatchlist));
    });
  }
}
