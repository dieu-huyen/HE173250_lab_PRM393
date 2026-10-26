
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class MovieService {
  static const String _baseUrl = 'https://api.tvmaze.com';

  Future<List<Movie>> fetchShows() async {
    final uri = Uri.parse('$_baseUrl/shows');

    final response = await http
        .get(uri)
        .timeout(const Duration(seconds: 20));

    if (response.statusCode != 200) {
      throw Exception(
        'API error: HTTP ${response.statusCode}',
      );
    }

    final List<dynamic> jsonList =
    jsonDecode(response.body) as List<dynamic>;

    return jsonList
        .map((item) => Movie.fromJson(
      item as Map<String, dynamic>,
    ))
        .toList();
  }

  Future<Movie> fetchShowDetail(int id) async {
    final uri = Uri.parse('$_baseUrl/shows/$id');

    final response = await http
        .get(uri)
        .timeout(const Duration(seconds: 20));

    if (response.statusCode != 200) {
      throw Exception(
        'Cannot load show details: HTTP ${response.statusCode}',
      );
    }

    final json = jsonDecode(response.body)
    as Map<String, dynamic>;

    return Movie.fromJson(json);
  }
}
