import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final Map<String, dynamic> user;
  final String token;

  const AuthAuthenticated(this.user, this.token);

  @override
  List<Object?> get props => [user, token];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthValidationError extends AuthState {
  final String message;

  const AuthValidationError(this.message);

  @override
  List<Object?> get props => [message];
}
