import 'package:equatable/equatable.dart';

abstract class VisibilityState extends Equatable {
  const VisibilityState();

  @override
  List<Object> get props => [];
}

class VisibilityInitial extends VisibilityState {}

class PasswordVisibilityToggled extends VisibilityState {
  final bool isVisible;

  const PasswordVisibilityToggled(this.isVisible);

  @override
  List<Object> get props => [isVisible];
}

class ConfirmPasswordVisibilityToggled extends VisibilityState {
  final bool isVisible;

  const ConfirmPasswordVisibilityToggled(this.isVisible);

  @override
  List<Object> get props => [isVisible];
}
