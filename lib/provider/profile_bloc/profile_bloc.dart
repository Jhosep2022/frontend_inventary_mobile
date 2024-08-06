import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/provider/profile_bloc/profile_event.dart';
import 'package:frontend_inventary_mobile/provider/profile_bloc/profile_state.dart';
import 'package:frontend_inventary_mobile/services/profile_service.dart';
import 'package:frontend_inventary_mobile/utils/toast_utils.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileService profileService;

  ProfileBloc(this.profileService) : super(ProfileInitial()) {
    on<UpdateUserRequested>(_onUpdateUserRequested);
    on<FetchUserById>(_onFetchUserById);
  }

  Future<void> _onUpdateUserRequested(UpdateUserRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      print('Starting user update for email: ${event.email}');
      final response = await profileService.updateUser(
        event.email,
        event.name,
        event.password,
        event.firstName,
        event.secondName,
        event.phone,
      );
      final user = response['data'];
      print('User update successful: $user');
      showSuccessToast('Datos actualizados con éxito');
      emit(ProfileUpdated(user));
      add(FetchUserById(user['id']));
    } catch (e) {
      print('User update failed: $e');
      showErrorToast(e.toString());
      emit(ProfileError('Error al actualizar los datos'));
    }
  }

  Future<void> _onFetchUserById(FetchUserById event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final response = await profileService.getUserById(event.id);
      final user = response['data'][0];
      print('User fetch successful: $user');
      emit(UserFetched(user));
    } catch (e) {
      print('User fetch failed: $e');
      showErrorToast(e.toString());
      emit(ProfileError('Error al obtener los datos del usuario'));
    }
  }
}
