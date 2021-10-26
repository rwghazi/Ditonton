part of 'recommendations_bloc.dart';

abstract class TvRecomendationState extends Equatable {
  const TvRecomendationState();

  @override
  List<Object> get props => [];
}

class TvRecomendationInitial extends TvRecomendationState {
  const TvRecomendationInitial();
}

class TvRecomendationLoading extends TvRecomendationState {
  const TvRecomendationLoading();
}

class TvRecomendationError extends TvRecomendationState {
  final String message;
  const TvRecomendationError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TvRecomendationError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class TvRecomendationLoaded extends TvRecomendationState {
  final List<Tv> tvs;
  const TvRecomendationLoaded(this.tvs);

  @override
  bool operator ==(Object tv) {
    if (identical(this, tv)) return true;

    return tv is TvRecomendationLoaded &&
        listEquals(tv.tvs, tvs);
  }

  @override
  int get hashCode => tvs.hashCode;
}
