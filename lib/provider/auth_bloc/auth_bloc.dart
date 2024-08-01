import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/provider/auth_bloc/auth_event.dart';
import 'package:frontend_inventary_mobile/provider/auth_bloc/auth_state.dart';
import 'package:frontend_inventary_mobile/services/authService.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    print('LoginRequested event received with email: ${event.email} and password: ${event.password}');
    
    if (event.email.isEmpty) {
      emit(AuthValidationError('El email es obligatorio'));
      return;
    }
    
    if (event.password.isEmpty) {
      emit(AuthValidationError('La contraseña es obligatoria'));
      return;
    }
    
    emit(AuthLoading());
    try {
      final user = await authService.loginUser(event.email, event.password);
      print('Login successful: $user');
      emit(AuthAuthenticated(user));
    } catch (e) {
      print('Login failed: $e');
      emit(AuthError('Por favor verifique sus usuario o contraseña'));
    }
  }
}
