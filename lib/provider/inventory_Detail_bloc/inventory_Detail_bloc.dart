import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/models/area.dart';
import 'package:frontend_inventary_mobile/models/producto.dart';
import 'package:frontend_inventary_mobile/provider/areas_bloc/areas_bloc.dart';
import 'package:frontend_inventary_mobile/provider/areas_bloc/areas_state.dart';
import 'package:frontend_inventary_mobile/provider/products_bloc/products_bloc.dart';
import 'package:frontend_inventary_mobile/provider/products_bloc/products_state.dart';
import 'inventory_detail_event.dart';
import 'inventory_detail_state.dart';

class InventoryDetailBloc extends Bloc<InventoryDetailEvent, InventoryDetailState> {
  final ProductsBloc productsBloc;
  final AreasBloc areasBloc;

  InventoryDetailBloc({
    required this.productsBloc,
    required this.areasBloc,
  }) : super(InventoryDetailInitial()) {
    // Registrar el manejador para el evento LoadInventoryDetail
    on<LoadInventoryDetail>(_onLoadInventoryDetail);
  }

  void _onLoadInventoryDetail(LoadInventoryDetail event, Emitter<InventoryDetailState> emit) async {
    emit(InventoryDetailLoading());

    try {
      final List<Producto> selectedProducts = (productsBloc.state is ProductsLoaded)
          ? (productsBloc.state as ProductsLoaded)
              .products
              .where((product) => event.productIds.contains(product.id))
              .toList()
          : [];

      final Area selectedArea = (areasBloc.state is AreasLoaded)
          ? (areasBloc.state as AreasLoaded)
              .areas
              .firstWhere(
                  (area) => area.id == event.areaId,
                  orElse: () => Area(
                        id: 0,
                        name: "Unknown",
                        status: 0,
                        idCompany: 0,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ))
          : Area(
              id: 0,
              name: "Unknown",
              status: 0,
              idCompany: 0,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            );

      emit(InventoryDetailLoaded(
        selectedProducts: selectedProducts,
        selectedArea: selectedArea,
      ));
    } catch (e) {
      emit(InventoryDetailError('Error loading inventory details'));
    }
  }
}
