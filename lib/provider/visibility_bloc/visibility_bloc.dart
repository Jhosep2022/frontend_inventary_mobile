import 'package:flutter_bloc/flutter_bloc.dart';
import 'visibility_event.dart';
import 'visibility_state.dart';

class VisibilityBloc extends Bloc<VisibilityEvent, VisibilityState> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  VisibilityBloc() : super(VisibilityInitial()) {
    on<TogglePasswordVisibility>((event, emit) {
      _isPasswordVisible = !_isPasswordVisible;
      emit(PasswordVisibilityToggled(_isPasswordVisible));
    });
    on<ToggleConfirmPasswordVisibility>((event, emit) {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
      emit(ConfirmPasswordVisibilityToggled(_isConfirmPasswordVisible));
    });
  }
}
