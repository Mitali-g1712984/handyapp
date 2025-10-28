import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Use one of these baseUrls depending on where you run:
  // For Android emulator use 10.0.2.2
  static const String baseUrl = 'http://192.168.7.131:8080'; // Android emulator
  // static const String baseUrl = 'http://localhost:8080'; // iOS simulator or Flutter web
  // static const String baseUrl = 'http://192.168.1.100:8080'; // replace with your PC LAN IP for real device

  Future<List<dynamic>> getUsers() async {
    final uri = Uri.parse('$baseUrl/api/users');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }

  Future<dynamic> createUser(Map<String,dynamic> data) async {
    final uri = Uri.parse('$baseUrl/api/users');
    final response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data)
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create user: ${response.body}');
    }
  }
}
