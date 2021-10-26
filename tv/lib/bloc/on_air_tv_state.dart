part of 'on_air_tv_bloc.dart';

abstract class OnAirTvState extends Equatable {
  const OnAirTvState();
  
  @override
  List<Object> get props => [];
}

class OnAirTvInitial extends OnAirTvState {}

class OnAirTvLoading extends OnAirTvState {}

class OnAirTvError extends OnAirTvState {
  final String message;
 
  OnAirTvError(this.message);
 
  @override
  List<Object> get props => [message];
}

class OnAirTvLoaded extends OnAirTvState {
  final List<Tv> result;
 
  OnAirTvLoaded(this.result);
 
  @override
  List<Object> get props => [result];
}