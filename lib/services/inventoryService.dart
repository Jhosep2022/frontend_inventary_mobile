import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:frontend_inventary_mobile/database/database_helper.dart';
import 'package:frontend_inventary_mobile/environment/environment.dart';
import 'package:frontend_inventary_mobile/models/area.dart';
import 'package:frontend_inventary_mobile/models/inventoryRequest.dart';
import 'package:frontend_inventary_mobile/models/producto.dart';
import 'package:frontend_inventary_mobile/models/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class InventoryService {
  final String baseUrl = Environment.apiUrl;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Getter para acceder a la instancia de DatabaseHelper
  DatabaseHelper get databaseHelper => _databaseHelper;

  // Método para verificar la conexión a internet
  Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    print('Estado de conectividad: $connectivityResult'); // Mostrar el estado exacto de la conectividad.

    // Devolverá true solo si tiene acceso a Wi-Fi o datos móviles
    bool hasConnection = connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi;
    print(hasConnection ? "Conexión a Internet detectada" : "Sin conexión a Internet");
    return hasConnection;
  }

  // Obtener productos del servidor o localmente según la conexión
  Future<RespuestaProductos> getProducts(int companyId) async {
    final bool hasInternet = await isConnected();
    print(hasInternet ? "Conectado a Internet" : "Sin conexión a Internet");

    if (hasInternet) {
      try {
        final RespuestaProductos serverResponse = await _fetchProductsFromServer(companyId);

        // Si se obtienen productos del servidor, se actualizan en la base de datos local.
        if (serverResponse.ok && serverResponse.data.isNotEmpty) {
          await _databaseHelper.deleteAllProducts(); // Limpiar la base de datos local
          for (var producto in serverResponse.data) {
            await _databaseHelper.insertProduct(producto);
          }
        }
        return serverResponse;
      } catch (e) {
        print('Error al obtener productos del servidor: $e');
        return await fetchProductsFromLocalDatabase();
      }
    } else {
      // Si no hay conexión, obtener productos de la base de datos local
      return await fetchProductsFromLocalDatabase();
    }
  }

  // Obtener productos desde el servidor
  Future<RespuestaProductos> _fetchProductsFromServer(int companyId) async {
    final token = await _secureStorage.read(key: 'token');
    final url = Uri.parse('$baseUrl/inventories/getproducto');

    final Map<String, dynamic> body = {
      'id_company': companyId.toString(),
    };

    print('Enviando solicitud a $url con cuerpo: $body y token: $token');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    print('Estado de la respuesta del servidor: ${response.statusCode}');
    print('Cuerpo de la respuesta del servidor: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 400) {
      try {
        final data = RespuestaProductos.fromRawJson(response.body);
        print('Productos decodificados: ${data.data}');
        return data;
      } catch (e) {
        print('Error decodificando productos: $e');
        throw Exception('Error decodificando productos.');
      }
    } else {
      print('Error al obtener productos del servidor: ${response.body}');
      throw Exception('Error al obtener productos del servidor.');
    }
  }

  // Obtener productos desde la base de datos local
  Future<RespuestaProductos> fetchProductsFromLocalDatabase() async {
    try {
      final localProducts = await _databaseHelper.getProducts();
      print('Productos obtenidos localmente: $localProducts');
      if (localProducts.isNotEmpty) {
        return RespuestaProductos(ok: true, resp: 200, msg: 'Datos de la base de datos local', data: localProducts);
      } else {
        print('No hay productos disponibles en la base de datos local.');
        return RespuestaProductos(ok: false, resp: 404, msg: 'No hay productos disponibles en la base de datos local', data: []);
      }
    } catch (e) {
      print('Error obteniendo productos localmente: $e');
      return RespuestaProductos(ok: false, resp: 500, msg: 'Error al obtener productos localmente', data: []);
    }
  }

  // Buscar productos en el servidor o desde la base de datos local si no hay conexión
  Future<RespuestaProductos> searchProducts(int companyId, String param) async {
    final token = await _secureStorage.read(key: 'token');
    final url = Uri.parse('$baseUrl/inventories/getproductobyparam');

    final Map<String, dynamic> body = {
      'id_company': companyId.toString(),
      'param': param,
    };

    bool isConnectedToInternet = await isConnected(); // Checar conectividad
    print(isConnectedToInternet ? 'En línea: Intentando buscar productos en el servidor.' : 'Sin conexión: Buscando productos localmente.');

    if (isConnectedToInternet) {
      print('En línea: Enviando solicitud de búsqueda a $url con cuerpo: $body y token: $token');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      print('Estado de la respuesta del servidor: ${response.statusCode}');
      print('Cuerpo de la respuesta del servidor: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final data = RespuestaProductos.fromRawJson(response.body);
          print('Productos decodificados: ${data.data}');
          return data;
        } catch (e) {
          print('Error decodificando productos: $e');
          throw Exception('Error decodificando productos.');
        }
      } else {
        print('Error al buscar productos: ${response.body}');
        throw Exception('Error al buscar productos. Respuesta del servidor: ${response.body}');
      }
    } else {
      print('Sin conexión: Buscando productos en la base de datos local.');
      return await _searchProductsOffline(param);
    }
  }

  // Método privado para buscar productos en la base de datos local (modo offline)
  Future<RespuestaProductos> _searchProductsOffline(String param) async {
    try {
      final localProducts = await _databaseHelper.getProducts();
      print('Productos obtenidos localmente: $localProducts');

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

  // Obtener productos locales
  Future<List<Producto>> getLocalProducts() async {
    try {
      final localProducts = await _databaseHelper.getProducts();
      return localProducts;
    } catch (e) {
      print('Error obteniendo productos locales: $e');
      throw Exception('Error obteniendo productos locales.');
    }
  }

  // Subir inventario al servidor
  Future<bool> uploadInventory(InventoryRequest inventoryRequest) async {
    final token = await _secureStorage.read(key: 'token');
    final url = Uri.parse('$baseUrl/inventories/createinventory');

    print('Enviando solicitud PUT a $url con cuerpo: ${inventoryRequest.toJson()} y token: $token');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(inventoryRequest.toJson()),
    );

    print('Estado de la respuesta del servidor: ${response.statusCode}');
    print('Cuerpo de la respuesta del servidor: ${response.body}');

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Error al subir el inventario: ${response.statusCode}');
      return false;
    }
  }

  // Sincronizar datos locales con el servidor
  Future<void> syncLocalData() async {
    if (await isConnected()) {
      print('Sincronizando datos locales con el servidor...');
      final localProducts = await _databaseHelper.getProducts();
      for (var product in localProducts) {
        await uploadProduct(product); // Subir cada producto al servidor
      }
      print('Sincronización completa.');
    } else {
      print('No se puede sincronizar: Sin conexión a Internet.');
    }
  }

  // Subir producto al servidor
  Future<void> uploadProduct(Producto product) async {
    final token = await _secureStorage.read(key: 'token');
    final url = Uri.parse('$baseUrl/inventories/createproduct');

    print('Enviando solicitud PUT a $url con cuerpo: ${product.toJson()} y token: $token');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 200) {
      print('Producto subido exitosamente.');
    } else {
      print('Error al subir producto: ${response.body}');
    }
  }

  // Obtener áreas del servidor
  Future<RespuestaAreas> getAreas(int companyId) async {
    final token = await _secureStorage.read(key: 'token');
    final url = Uri.parse('$baseUrl/inventories/getarea');

    final Map<String, dynamic> body = {
      'id_company': companyId.toString(),
    };

    print('Enviando solicitud a $url con cuerpo: $body y token: $token');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    print('Estado de la respuesta del servidor: ${response.statusCode}');
    print('Cuerpo de la respuesta del servidor: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 400) {
      try {
        final data = RespuestaAreas.fromRawJson(response.body);
        print('Áreas decodificadas: ${data.data}');
        return data;
      } catch (e) {
        print('Error decodificando áreas: $e');
        throw Exception('Error decodificando áreas.');
      }
    } else {
      print('Error al obtener áreas del servidor: ${response.body}');
      throw Exception('Error al obtener áreas del servidor.');
    }
  }

  // Obtener usuarios del servidor
  Future<RespuestaUsuario> getUsers(int companyId) async {
    final token = await _secureStorage.read(key: 'token');
    final url = Uri.parse('$baseUrl/inventories/getusuarios');

    final Map<String, dynamic> body = {
      'id_company': companyId.toString(),
    };

    print('Enviando solicitud a $url con cuerpo: $body y token: $token');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    print('Estado de la respuesta del servidor: ${response.statusCode}');
    print('Cuerpo de la respuesta del servidor: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 400) {
      try {
        final data = RespuestaUsuario.fromRawJson(response.body);
        print('Usuarios decodificados: ${data.data}');
        return data;
      } catch (e) {
        print('Error decodificando usuarios: $e');
        throw Exception('Error decodificando usuarios.');
      }
    } else {
      print('Error al obtener usuarios del servidor: ${response.body}');
      throw Exception('Error al obtener usuarios del servidor.');
    }
  }
}
