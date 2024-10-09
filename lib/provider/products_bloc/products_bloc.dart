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
      final bool isConnected = await inventoryService.isConnected();
      print(isConnected ? 'Online: Fetching products from server.' : 'Offline: Fetching products from local database.');

      RespuestaProductos respuesta;
      if (isConnected) {
        respuesta = await inventoryService.getProducts(event.companyId);
      } else {
        respuesta = await inventoryService.fetchProductsFromLocalDatabase();
      }

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

  // Método para manejar el evento SearchProducts
  Future<void> _onSearchProducts(SearchProducts event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      print('Searching products for companyId: ${event.companyId} with param: ${event.param}');
      final bool isConnected = await inventoryService.isConnected();

      RespuestaProductos respuesta;

      if (isConnected) {
        // Buscar productos en línea si hay conexión
        print('En línea: Buscando productos desde el servidor.');
        respuesta = await inventoryService.searchProducts(event.companyId, event.param);
      } else {
        // Buscar productos en modo offline en la base de datos local
        print('Sin conexión: Buscando productos localmente.');
        respuesta = await _searchProductsOffline(event.param);
      }

      // Emitir el estado de productos cargados, ya sea desde el servidor o localmente
      if (respuesta.ok && respuesta.data.isNotEmpty) {
        print('Products found successfully: ${respuesta.data}');
        emit(ProductsLoaded(respuesta.data));
      } else {
        print('No products found for the search.');
        emit(ProductsError('No se encontraron productos para la búsqueda.'));
      }
    } catch (e) {
      print('Failed to search products: $e');
      // Emitir un mensaje de error basado en el tipo de excepción
      if (e.toString().contains('SocketException')) {
        emit(ProductsError('Error de conexión: No se pudo establecer la conexión con el servidor.'));
      } else {
        emit(ProductsError('Falló la búsqueda de productos. Exception: $e'));
      }
    }
  }

  // Método privado para buscar productos en la base de datos local (modo offline)
  Future<RespuestaProductos> _searchProductsOffline(String param) async {
    try {
      final localProducts = await inventoryService.getLocalProducts();

      if (localProducts.isNotEmpty) {
        // Filtrar productos locales según el parámetro de búsqueda
        final filteredProducts = localProducts.where((p) => p.name.toLowerCase().contains(param.toLowerCase())).toList();

        if (filteredProducts.isNotEmpty) {
          print('Productos encontrados localmente: $filteredProducts');
          return RespuestaProductos(ok: true, resp: 200, msg: 'Datos de la base de datos local', data: filteredProducts);
        } else {
          print('No hay productos que coincidan con la búsqueda en la base de datos local.');
          return RespuestaProductos(ok: false, resp: 404, msg: 'No hay productos que coincidan con la búsqueda en la base de datos local', data: []);
        }
      } else {
        print('No hay productos disponibles offline.');
        return RespuestaProductos(ok: false, resp: 404, msg: 'No hay productos disponibles offline.', data: []);
      }
    } catch (e) {
      print('Error al buscar productos localmente: $e');
      return RespuestaProductos(ok: false, resp: 500, msg: 'Error al buscar productos localmente.', data: []);
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
