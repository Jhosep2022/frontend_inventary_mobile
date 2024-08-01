import 'package:frontend_inventary_mobile/environment/environment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordService {
  final String baseUrl = Environment.apiUrl;

  Future<Map<String, dynamic>> sendRecoveryEmail(String email) async {
    final url = Uri.parse('$baseUrl/users/recovermail');
    print('Request URL: $url');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    print('Request body: ${jsonEncode({'email': email})}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to send recovery email');
    }
  }
}
