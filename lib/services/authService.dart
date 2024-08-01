import 'package:frontend_inventary_mobile/environment/environment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String baseUrl = Environment.apiUrl;

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
}
