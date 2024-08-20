import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LogoutRequested extends AuthEvent {}


class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class UpdateUserDetails extends AuthEvent {
  final Map<String, dynamic> updatedUserDetails;

  const UpdateUserDetails(this.updatedUserDetails);

  @override
  List<Object> get props => [updatedUserDetails];
}

class AppStarted extends AuthEvent {}

