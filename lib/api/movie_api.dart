import 'dart:convert';

import 'package:amifactory_test_app/domain/entity/movie.dart';
import 'package:http/http.dart' as http;

class MovieApi {
  static Future<List<Movie>> getMovies([int page = 0]) async {
    final url =
        Uri.parse('https://live.mocat.amifactory.network/api/v1/movies/?page=$page');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> movies = map['results'];
      final result = movies.map((json) => Movie.fromJson(json)).toList();
      return result;
    } else {
      throw Exception();
    }
  }
}
