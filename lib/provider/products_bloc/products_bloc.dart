import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/models/producto.dart';
import 'package:frontend_inventary_mobile/services/inventoryService.dart';
import 'products_event.dart';
import 'products_state.dart';
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final InventoryService inventoryService;

  ProductsBloc(this.inventoryService) : super(ProductsInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(FetchProducts event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      print('Fetching products for companyId: ${event.companyId}');
      final RespuestaProductos respuesta = await inventoryService.getProducts(event.companyId);

      if (respuesta.ok && respuesta.data.isNotEmpty) {
        print('Products fetched successfully: ${respuesta.data}');
        emit(ProductsLoaded(respuesta.data)); // Emitimos la lista completa de objetos Producto
      } else {
        print('No products found.');
        emit(ProductsError('No products found.'));
      }
    } catch (e) {
      print('Failed to load products: $e');
      emit(ProductsError('Failed to load products. Exception: $e'));
    }
  }
}

