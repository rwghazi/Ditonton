part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object> get props => [];
}

class WatchlistTvInitial extends WatchlistTvState {}

class WatchlistTvLoading extends WatchlistTvState {}

class WatchlistTvError extends WatchlistTvState {
  final String message;

  WatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}
class WatchlistTvLoaded extends WatchlistTvState {
  final List<Tv> result;

  WatchlistTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistTvStatus extends WatchlistTvState {
  final bool result;

  WatchlistTvStatus(this.result);

  @override
  List<Object> get props => [result];
}
