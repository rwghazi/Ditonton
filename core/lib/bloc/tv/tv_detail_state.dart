part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailInitial extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailError extends TvDetailState {
  final String message;

  TvDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailLoaded extends TvDetailState {
  final TvDetail result;
  final bool isAddedToWatchlist;

  TvDetailLoaded(this.result, this.isAddedToWatchlist);

  @override
  bool operator ==(Object tv) {
    if (identical(this, tv)) return true;

    return tv is TvDetailLoaded &&
        tv.result == result &&
        tv.isAddedToWatchlist == isAddedToWatchlist;
  }
}

class TvWatchlist extends TvDetailState {
  final String message;
  final TvDetail tv;
  final bool isAddedToWatchlist;
  const TvWatchlist(this.message, this.tv, this.isAddedToWatchlist);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TvWatchlist &&
        other.message == message &&
        other.tv == tv &&
        other.isAddedToWatchlist == isAddedToWatchlist;
  }

  @override
  int get hashCode =>
      message.hashCode ^ tv.hashCode ^ isAddedToWatchlist.hashCode;
}