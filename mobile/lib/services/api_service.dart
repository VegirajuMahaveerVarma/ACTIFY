import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  const ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> extractTask(String input) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/ai/extract-task'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'input': input}),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('AI request failed: ${response.statusCode}');
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
