import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/models/producto.dart';
import 'package:frontend_inventary_mobile/services/inventoryService.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final InventoryService inventoryService;

  ProductsBloc(this.inventoryService) : super(ProductsInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<SearchProducts>(_onSearchProducts);
    on<SyncProducts>(_onSyncProducts); 
  }

  // Método para manejar el evento FetchProducts
  Future<void> _onFetchProducts(FetchProducts event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      // Intentar obtener productos desde el servidor
      final bool isConnected = await inventoryService.isConnected();
      if (isConnected) {
        print('Online: Fetching products for companyId: ${event.companyId}');
        final RespuestaProductos respuesta = await inventoryService.getProducts(event.companyId);

        if (respuesta.ok && respuesta.data.isNotEmpty) {
          print('Products fetched successfully: ${respuesta.data}');
          emit(ProductsLoaded(respuesta.data)); 
        } else {
          print('No products found.');
          emit(ProductsError('No products found.'));
        }
      } else {
        print('Offline: Fetching products from local database.');
        final List<Producto> localProducts = await inventoryService.getLocalProducts(); 

        if (localProducts.isNotEmpty) {
          print('Local products fetched successfully: $localProducts');
          emit(ProductsOfflineLoaded(localProducts)); 
        } else {
          print('No products found in local database.');
          emit(ProductsError('No products available offline.'));
        }
      }
    } catch (e) {
      print('Failed to load products: $e');
      emit(ProductsError('Failed to load products. Exception: $e'));
    }
  }

  // Método para manejar el evento SearchProducts
  Future<void> _onSearchProducts(SearchProducts event, Emitter<ProductsState> emit) async {
  emit(ProductsLoading());
    try {
      print('Searching products for companyId: ${event.companyId} with param: ${event.param}');

      final bool isConnected = await inventoryService.isConnected();
      RespuestaProductos respuesta;

      if (isConnected) {
        print('En línea: Buscando productos desde el servidor.');
        respuesta = await inventoryService.searchProducts(event.companyId, event.param);
      } else {
        print('Sin conexión: Buscando productos localmente.');
        respuesta = await inventoryService.searchProducts(event.companyId, event.param);
      }

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

  // Método para manejar el evento SyncProducts (sincronización)
  Future<void> _onSyncProducts(SyncProducts event, Emitter<ProductsState> emit) async {
    try {
      print('Synchronizing local products with the server...');
      await inventoryService.syncLocalData(); 
      emit(ProductsSynced()); 
    } catch (e) {
      print('Failed to sync products: $e');
      emit(ProductsError('Failed to sync products. Exception: $e'));
    }
  }
}
