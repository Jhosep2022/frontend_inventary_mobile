import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/provider/forgot_password_bloc/forgot_password_event.dart';
import 'package:frontend_inventary_mobile/provider/forgot_password_bloc/forgot_password_state.dart';
import 'package:frontend_inventary_mobile/services/forgotPasswordService.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordService forgotPasswordService;

  ForgotPasswordBloc(this.forgotPasswordService) : super(ForgotPasswordInitial()) {
    on<SendRecoveryEmail>(_onSendRecoveryEmail);
  }

  Future<void> _onSendRecoveryEmail(SendRecoveryEmail event, Emitter<ForgotPasswordState> emit) async {
    print('SendRecoveryEmail event received with email: ${event.email}');
    
    if (event.email.isEmpty) {
      emit(ForgotPasswordValidationError('El email es obligatorio'));
      return;
    }
    
    emit(ForgotPasswordLoading());
    try {
      final response = await forgotPasswordService.sendRecoveryEmail(event.email);
      print('Recovery email sent: $response');
      emit(ForgotPasswordSuccess('Email de recuperación enviado con éxito'));
    } catch (e) {
      print('Recovery email failed: $e');
      emit(ForgotPasswordError('Error al enviar el email de recuperación'));
    }
  }
}
