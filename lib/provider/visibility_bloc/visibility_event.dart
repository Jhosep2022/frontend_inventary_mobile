import 'package:equatable/equatable.dart';

abstract class VisibilityEvent extends Equatable {
  const VisibilityEvent();

  @override
  List<Object> get props => [];
}

class TogglePasswordVisibility extends VisibilityEvent {}

class ToggleConfirmPasswordVisibility extends VisibilityEvent {}