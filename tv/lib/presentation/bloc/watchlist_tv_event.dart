part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistTv extends WatchlistTvEvent {}

class AddToWatchList extends WatchlistTvEvent {
  final TvDetail tv;

  AddToWatchList(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveWatchList extends WatchlistTvEvent {
  final TvDetail tv;

  RemoveWatchList(this.tv);

  @override
  List<Object> get props => [tv];
}

class LoadWatchListStatus extends WatchlistTvEvent {
  final int id;

  LoadWatchListStatus(this.id);

  @override
  List<Object> get props => [id];
}
