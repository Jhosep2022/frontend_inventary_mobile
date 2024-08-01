import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class SendRecoveryEmail extends ForgotPasswordEvent {
  final String email;

  const SendRecoveryEmail(this.email);

  @override
  List<Object> get props => [email];
}