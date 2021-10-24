part of 'recommendations_bloc.dart';

abstract class RecomendationState extends Equatable {
  const RecomendationState();

  @override
  List<Object> get props => [];
}

class RecomendationInitial extends RecomendationState {
  const RecomendationInitial();
}

class RecomendationLoading extends RecomendationState {
  const RecomendationLoading();
}

class RecomendationError extends RecomendationState {
  final String message;
  const RecomendationError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecomendationError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class RecomendationLoaded extends RecomendationState {
  final List<Tv> tvs;
  const RecomendationLoaded(this.tvs);

  @override
  bool operator ==(Object tv) {
    if (identical(this, tv)) return true;

    return tv is RecomendationLoaded &&
        listEquals(tv.tvs, tvs);
  }

  @override
  int get hashCode => tvs.hashCode;
}
