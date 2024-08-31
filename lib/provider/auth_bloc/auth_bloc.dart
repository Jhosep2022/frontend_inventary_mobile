import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_inventary_mobile/provider/auth_bloc/auth_event.dart';
import 'package:frontend_inventary_mobile/provider/auth_bloc/auth_state.dart';
import 'package:frontend_inventary_mobile/services/authService.dart';
import 'package:frontend_inventary_mobile/utils/toast_utils.dart';
import 'package:jwt_decode/jwt_decode.dart';
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<UpdateUserDetails>(_onUpdateUserDetails);
    on<AppStarted>(_onAppStarted);
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    print(
        'LoginRequested event received with email: ${event.email} and password: ${event.password}');

    if (event.email.isEmpty) {
      emit(AuthValidationError('El email es obligatorio'));
      showErrorToast('El email es obligatorio');
      return;
    }

    if (event.password.isEmpty) {
      emit(AuthValidationError('La contraseña es obligatoria'));
      showErrorToast('La contraseña es obligatoria');
      return;
    }

    emit(AuthLoading());
    try {
      final response = await authService.loginUser(event.email, event.password);
      final user = response['data'][0]['user'];
      final token = response['data'][0]['token'];

      await _secureStorage.deleteAll();
      await _secureStorage.write(key: 'token', value: token);
      await _secureStorage.write(key: 'userId', value: user['id'].toString());

      print('Login successful: $user');
      showSuccessToast('Inicio de sesión exitoso');
      emit(AuthAuthenticated(user, token));
    } catch (e) {
      print('Login failed: $e');
      showErrorToast('Por favor verifique sus usuario o contraseña');
      emit(AuthError('Por favor verifique sus usuario o contraseña'));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    await _secureStorage.deleteAll();
    emit(AuthInitial());
  }

  Future<void> _onUpdateUserDetails(
      UpdateUserDetails event, Emitter<AuthState> emit) async {
    print('Updating global user details: ${event.updatedUserDetails}');
    final token = await _secureStorage.read(key: 'token') ?? 'default_token';
    emit(AuthAuthenticated(event.updatedUserDetails, token));
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final token = await _secureStorage.read(key: 'token');
    final userId = await _secureStorage.read(key: 'userId');

    if (token != null && userId != null) {
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      DateTime expirationDate = Jwt.getExpiryDate(token)!;

      if (DateTime.now().isBefore(expirationDate)) {
        final user = {'id': userId};
        emit(AuthAuthenticated(user, token));
      } else {
        await _secureStorage.deleteAll();
        emit(AuthInitial());
      }
    } else {
      emit(AuthInitial());
    }
  }
}
