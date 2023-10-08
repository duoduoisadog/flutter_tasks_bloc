part of 'switch_bloc.dart';

sealed class SwitchEvent extends Equatable {
  const SwitchEvent();

  @override
  List<Object> get props => [];
}

final class SwitchOnEvent extends SwitchEvent {}

final class SwitchOffEvent extends SwitchEvent {}
