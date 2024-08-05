import 'package:frontend_inventary_mobile/environment/environment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String baseUrl = Environment.apiUrl;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/users/login');

    final body = jsonEncode({'email': email, 'password': password});

    final request = http.Request('POST', url)
      ..headers.addAll({'Content-Type': 'application/json'})
      ..body = body;

    final response = await request.send();
    final responseString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return json.decode(responseString);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>> updateUser(String email, String name, String? password, String firstName, String secondName, String phone) async {
    final token = await _secureStorage.read(key: 'token');
    final url = Uri.parse('$baseUrl/users/updateuser');

    final body = jsonEncode({
      'email': email,
      'name': name,
      'password': password,
      'first_name': firstName,
      'second_name': secondName,
      'phone': phone,
    });

    print('Updating user with body: $body');
    print('Using token: $token');

    final request = http.Request('PUT', url)
      ..headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      })
      ..body = body;

    final response = await request.send();
    final responseString = await response.stream.bytesToString();

    print('Response status: ${response.statusCode}');
    print('Response body: $responseString');

    if (response.statusCode == 200) {
      return json.decode(responseString);
    } else {
      throw Exception('Failed to update user');
    }
  }
}
