part of 'watchlist_page_bloc.dart';

abstract class WatchlistPageState extends Equatable {
  const WatchlistPageState();
  
  @override
  List<Object> get props => [];
}

class WatchlistPageInitial extends WatchlistPageState {}

class WatchlistPageLoading extends WatchlistPageState {}

class WatchlistPageError extends WatchlistPageState {
  final String message;

  WatchlistPageError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistPageLoaded extends WatchlistPageState {
  final List<Tv> result;

  WatchlistPageLoaded(this.result);

  @override
  List<Object> get props => [result];
}
