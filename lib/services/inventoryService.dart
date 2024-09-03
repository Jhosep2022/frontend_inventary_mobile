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

  Future<RespuestaProductos> getProducts(int companyId) async {
    final token = await _secureStorage.read(key: 'token');
    final url = Uri.parse('$baseUrl/inventories/getproducto');

    final Map<String, dynamic> body = {
      'id_company': companyId.toString(),
    };

    print('Sending request to $url with body: $body and token: $token');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    print('Server response status: ${response.statusCode}');
    print('Server response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 400) {  
      try {
        final data = RespuestaProductos.fromRawJson(response.body);
        print('Productos decodificados: ${data.data}');
        return data;
      } catch (e) {
        print('Error decoding products: $e');
        throw Exception('Error decoding products.');
      }
    } else {
      print('Failed to fetch products: ${response.body}');
      throw Exception('Failed to fetch products. Server responded with: ${response.body}');
    }
  }

  Future<RespuestaAreas> getAreas(int companyId) async {
    final token = await _secureStorage.read(key: 'token');
    final url = Uri.parse('$baseUrl/inventories/getarea');

    final Map<String, dynamic> body = {
      'id_company': companyId.toString(),
    };

    print('Sending request to $url with body: $body and token: $token');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    print('Server response status: ${response.statusCode}');
    print('Server response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 400) {  
      try {
        final data = RespuestaAreas.fromRawJson(response.body);
        print('Areas decodificadas: ${data.data}');
        return data;
      } catch (e) {
        print('Error decoding areas: $e');
        throw Exception('Error decoding areas.');
      }
    } else {
      print('Failed to fetch areas: ${response.body}');
      throw Exception('Failed to fetch areas. Server responded with: ${response.body}');
    }
  }

  Future<RespuestaUsuario> getUsers(int companyId) async {
    final token = await _secureStorage.read(key: 'token');
    final url = Uri.parse('$baseUrl/inventories/getusuarios');

    final Map<String, dynamic> body = {
      'id_company': companyId.toString(),
    };

    print('Sending request to $url with body: $body and token: $token');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    print('Server response status: ${response.statusCode}');
    print('Server response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 400) {
      try {
        final data = RespuestaUsuario.fromRawJson(response.body);
        print('Usuarios decodificados: ${data.data}');
        return data;
      } catch (e) {
        print('Error decoding users: $e');
        throw Exception('Error decoding users.');
      }
    } else {
      print('Failed to fetch users: ${response.body}');
      throw Exception('Failed to fetch users. Server responded with: ${response.body}');
    }
  }

  Future<RespuestaProductos> searchProducts(int companyId, String param) async {
    final token = await _secureStorage.read(key: 'token');
    final url = Uri.parse('$baseUrl/inventories/getproductobyparam');

    final Map<String, dynamic> body = {
      'id_company': companyId.toString(),
      'param': param,
    };

    print('Sending request to $url with body: $body and token: $token');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    print('Server response status: ${response.statusCode}');
    print('Server response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 400) {  
      try {
        final data = RespuestaProductos.fromRawJson(response.body);
        print('Productos decodificados: ${data.data}');
        return data;
      } catch (e) {
        print('Error decoding products: $e');
        throw Exception('Error decoding products.');
      }
    } else {
      print('Failed to fetch products: ${response.body}');
      throw Exception('Failed to fetch products. Server responded with: ${response.body}');
    }
  }

  Future<bool> uploadInventory(InventoryRequest inventoryRequest) async {
    final token = await _secureStorage.read(key: 'token');
    final url = Uri.parse('$baseUrl/inventories/createinventory');

    print('Sending PUT request to $url with body: ${inventoryRequest.toJson()} and token: $token');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(inventoryRequest.toJson()),
    );

    print('Server response status: ${response.statusCode}');
    print('Server response body: ${response.body}');

    if (response.statusCode == 200) {
      // Aquí puedes manejar una respuesta exitosa, como analizar el JSON o devolver un estado específico.
      return true;
    } else {
      // Manejar errores
      print('Failed to upload inventory: ${response.statusCode}');
      return false;
    }
  }
}
