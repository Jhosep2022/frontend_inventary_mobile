import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/models/inventoryRequest.dart';
import 'package:frontend_inventary_mobile/provider/InventoryBloc/inventory_event.dart';
import 'package:frontend_inventary_mobile/provider/InventoryBloc/inventory_state.dart';
import 'package:frontend_inventary_mobile/services/inventoryService.dart';
import 'package:frontend_inventary_mobile/utils/toast_utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final InventoryService inventoryService;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  InventoryBloc(this.inventoryService) : super(InventoryInitial()) {
    on<UploadInventory>(_onUploadInventory);
  }

  Future<void> _onUploadInventory(
      UploadInventory event, Emitter<InventoryState> emit) async {
    emit(InventoryLoading());
    try {
      final success = await inventoryService.uploadInventory(event.inventoryRequest);
      if (success) {
        showSuccessToast('Inventario subido con éxito');
        emit(InventorySuccess());
      } else {
        showErrorToast('Error al subir el inventario');
        emit(InventoryError('Error al subir el inventario'));
      }
    } catch (e) {
      showErrorToast('Error al subir el inventario: $e');
      emit(InventoryError('Error al subir el inventario: $e'));
    }
  }
}
