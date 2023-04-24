part of 'cast_cubit.dart';

abstract class CastState {}

class CastInitial extends CastState {}

class CastLoading extends CastState {}

class CastLoaded extends CastState {
  CastLoaded(this.cast);

  final List<Cast> cast;
}

class CastLoadFailed extends CastState {}