import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/models/area.dart';
import 'package:frontend_inventary_mobile/services/inventoryService.dart';
import 'areas_event.dart';
import 'areas_state.dart';

class AreasBloc extends Bloc<AreasEvent, AreasState> {
  final InventoryService inventoryService;

  AreasBloc(this.inventoryService) : super(AreasInitial()) {
    on<FetchAreas>(_onFetchAreas);
  }

  Future<void> _onFetchAreas(FetchAreas event, Emitter<AreasState> emit) async {
    emit(AreasLoading());
    try {
      final RespuestaAreas respuesta = await inventoryService.getAreas(event.companyId);

      if (respuesta.ok && respuesta.data.isNotEmpty) {
        emit(AreasLoaded(respuesta.data)); // Emitimos la lista de objetos Area
      } else {
        emit(AreasError('No areas found.'));
      }
    } catch (e) {
      emit(AreasError('Failed to load areas. Exception: $e'));
    }
  }
}


