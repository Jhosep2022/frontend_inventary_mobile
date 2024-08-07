import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/provider/forgot_password_bloc/forgot_password_event.dart';
import 'package:frontend_inventary_mobile/provider/forgot_password_bloc/forgot_password_state.dart';
import 'package:frontend_inventary_mobile/services/forgotPasswordService.dart';
import 'package:frontend_inventary_mobile/utils/toast_utils.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordService forgotPasswordService;

  ForgotPasswordBloc(this.forgotPasswordService) : super(ForgotPasswordInitial()) {
    on<SendRecoveryEmail>(_onSendRecoveryEmail);
  }

  Future<void> _onSendRecoveryEmail(SendRecoveryEmail event, Emitter<ForgotPasswordState> emit) async {
    print('SendRecoveryEmail event received with email: ${event.email}');
    
    if (event.email.isEmpty) {
      showErrorToast('El email es obligatorio');
      return;
    }
    
    try {
      final response = await forgotPasswordService.sendRecoveryEmail(event.email);
      print('Recovery email sent: $response');
      showSuccessToast('Email de recuperación enviado con éxito');
    } catch (e) {
      print('Recovery email failed: $e');
      showErrorToast('Error al enviar el email de recuperación');
    }
  }
}
