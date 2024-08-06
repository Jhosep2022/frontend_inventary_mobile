import 'package:equatable/equatable.dart';

abstract class VisibilityLoginState extends Equatable {
  const VisibilityLoginState();

  @override
  List<Object> get props => [];
}

class VisibilityLoginInitial extends VisibilityLoginState {}

class PasswordVisibilityToggled extends VisibilityLoginState {
  final bool isVisible;

  const PasswordVisibilityToggled(this.isVisible);

  @override
  List<Object> get props => [isVisible];
}
