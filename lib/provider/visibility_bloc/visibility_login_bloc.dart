import 'package:flutter_bloc/flutter_bloc.dart';
import 'visibility_login_event.dart';
import 'visibility_login_state.dart';

class VisibilityLoginBloc extends Bloc<VisibilityLoginEvent, VisibilityLoginState> {
  bool _isPasswordVisible = false;

  VisibilityLoginBloc() : super(VisibilityLoginInitial()) {
    on<TogglePasswordVisibility>((event, emit) {
      _isPasswordVisible = !_isPasswordVisible;
      emit(PasswordVisibilityToggled(_isPasswordVisible));
    });
  }
}
