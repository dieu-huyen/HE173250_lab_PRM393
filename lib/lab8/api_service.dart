
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://jsonplaceholder.typicode.com';

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/posts'))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to load posts: HTTP ${response.statusCode}',
        );
      }

      final List<dynamic> data = jsonDecode(response.body);

      return data.map<Map<String, dynamic>>((item) {
        return Map<String, dynamic>.from(item as Map);
      }).toList();
    } on TimeoutException {
      throw Exception(
        'Request timed out. Please try again.',
      );
    } on http.ClientException {
      throw Exception(
        'Network error. Please check your connection.',
      );
    }
  }
}
