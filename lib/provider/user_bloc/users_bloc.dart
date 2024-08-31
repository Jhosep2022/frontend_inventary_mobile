import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/models/usuario.dart';
import 'package:frontend_inventary_mobile/services/inventoryService.dart';
import 'users_event.dart';
import 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final InventoryService inventoryService;

  UsersBloc(this.inventoryService) : super(UsersInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UsersState> emit) async {
    emit(UsersLoading());
    try {
      print('Fetching users for companyId: ${event.companyId}');
      final RespuestaUsuario respuesta = await inventoryService.getUsers(event.companyId);

      if (respuesta.ok && respuesta.data.isNotEmpty) {
        print('Users fetched successfully: ${respuesta.data}');
        emit(UsersLoaded(respuesta.data)); // Emitimos la lista de usuarios
      } else {
        print('No users found.');
        emit(UsersError('No users found.'));
      }
    } catch (e) {
      print('Failed to load users: $e');
      emit(UsersError('Failed to load users. Exception: $e'));
    }
  }
}
