import 'package:equatable/equatable.dart';

abstract class VisibilityLoginEvent extends Equatable {
  const VisibilityLoginEvent();

  @override
  List<Object> get props => [];
}

class TogglePasswordVisibility extends VisibilityLoginEvent {}
