import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/models/producto.dart';
import 'package:frontend_inventary_mobile/services/inventoryService.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final InventoryService inventoryService;

  ProductsBloc(this.inventoryService) : super(ProductsInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<SearchProducts>(_onSearchProducts); // Asegúrate de que este manejador esté presente
  }

  Future<void> _onFetchProducts(FetchProducts event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      print('Fetching products for companyId: ${event.companyId}');
      final RespuestaProductos respuesta = await inventoryService.getProducts(event.companyId);

      if (respuesta.ok && respuesta.data.isNotEmpty) {
        print('Products fetched successfully: ${respuesta.data}');
        emit(ProductsLoaded(respuesta.data)); 
      } else {
        print('No products found.');
        emit(ProductsError('No products found.'));
      }
    } catch (e) {
      print('Failed to load products: $e');
      emit(ProductsError('Failed to load products. Exception: $e'));
    }
  }

  Future<void> _onSearchProducts(SearchProducts event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      print('Searching products for companyId: ${event.companyId} with param: ${event.param}');
      final RespuestaProductos respuesta = await inventoryService.searchProducts(event.companyId, event.param);

      if (respuesta.ok && respuesta.data.isNotEmpty) {
        print('Products found successfully: ${respuesta.data}');
        emit(ProductsLoaded(respuesta.data));
      } else {
        print('No products found for the search.');
        emit(ProductsError('No products found for the search.'));
      }
    } catch (e) {
      print('Failed to search products: $e');
      emit(ProductsError('Failed to search products. Exception: $e'));
    }
  }
}
