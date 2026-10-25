import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  const ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> extractTask(String input) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/api/ai/extract-task'),
          headers: const {'Content-Type': 'application/json'},
          body: jsonEncode({'input': input}),
        )
        .timeout(const Duration(seconds: 25));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('AI request failed with status ${response.statusCode}');
    }
    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('API returned an unexpected response');
    }
    return decoded;
  }
}
