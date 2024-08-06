import 'package:frontend_inventary_mobile/environment/environment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileService {
  final String baseUrl = Environment.apiUrl;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> updateUser(String email, String name, String? password, String firstName, String secondName, String phone) async {
    final token = await _secureStorage.read(key: 'token');
    final url = Uri.parse('$baseUrl/users/updateuser');

    final Map<String, dynamic> body = {
      'email': email,
      'name': name,
      'first_name': firstName,
      'second_name': secondName,
      'phone': phone,
      'password': password ?? ''
    };

    print('Updating user with body: $body');
    print('Using token: $token');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update user. Server responded with: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getUserById(int id) async {
    final token = await _secureStorage.read(key: 'token');
    final url = Uri.parse('$baseUrl/users/userbyid');

    final Map<String, dynamic> body = {
      'id': id,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch user. Server responded with: ${response.body}');
    }
  }
}