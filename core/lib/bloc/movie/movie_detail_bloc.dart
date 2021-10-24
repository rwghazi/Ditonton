import 'package:bloc/bloc.dart';
import 'package:core/domain/movie/entities/movie_detail.dart';
import 'package:core/domain/movie/usecases/get_movie_detail.dart';
import 'package:core/domain/movie/usecases/get_watchlist_status.dart';
import 'package:core/domain/movie/usecases/remove_watchlist.dart';
import 'package:core/domain/movie/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Cubit<MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetWatchListStatus watchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc(this.getMovieDetail, this.watchListStatus, this.saveWatchlist,
      this.removeWatchlist)
      : super(MovieDetailInitial());

  Future<void> getDetailMovie(int id) async {
    emit(MovieDetailLoading());
    final result = await getMovieDetail.execute(id);
    final isAddedToWatchlist = await watchListStatus.execute(id);
    result.fold((failure) {
      emit(MovieDetailError(failure.message));
    }, (result) {
      emit(MovieDetailLoaded(result, isAddedToWatchlist));
    });
  }

  Future<void> saveToWatchlist(
      MovieDetail movie, bool isAddedToWatchlist) async {
    emit(MovieDetailLoading());
    final result = await saveWatchlist.execute(movie);
    result.fold((failure) {
      emit(MovieDetailError(failure.message));
    }, (result) {
      emit(MovieWatchlist(result, movie, isAddedToWatchlist));
    });
  }

  Future<void> removeFromWatchlist(
      MovieDetail data, bool isAddedToWatchlist) async {
    emit(MovieDetailLoading());
    final result = await removeWatchlist.execute(data);
    result.fold((failure) {
      emit(MovieDetailError(failure.message));
    }, (result) {
      emit(MovieWatchlist(result, data, isAddedToWatchlist));
    });
  }
}
