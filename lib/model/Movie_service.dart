import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/movie_response.dart';
 

class MovieService {
  static Future<List<Movie>> getSuggestions(int movieId) async {
    final url = Uri.parse(
      'https://yts.mx/api/v2/movie_suggestions.json?movie_id=$movieId',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final moviesJson = jsonBody['data']['movies'] as List<dynamic>;
      print("moviesJson : ${moviesJson.length}");
      return moviesJson.map((m) => Movie.fromJson(m)).toList();
    } else {
      throw Exception("فشل في تحميل الأفلام");
    }
  }
}
