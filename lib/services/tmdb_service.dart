import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moviemania/constant.dart';

class TMDBService {
  final String baseUrl = tmdbBaseUrl;
  final String apiKey = tmdbApiKey;

  // Fetch Trending Movies
  Future<List<dynamic>> fetchTrendingMovies() async {
    final url = Uri.parse('$baseUrl/trending/movie/week?api_key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to fetch trending movies');
    }
  }

  // Fetch Top Rated Movies
  Future<List<dynamic>> fetchTopRatedMovies() async {
    final url = Uri.parse('$baseUrl/movie/top_rated?api_key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to fetch top-rated movies');
    }
  }

  // Fetch Upcoming Movies
  Future<List<dynamic>> fetchUpcomingMovies() async {
    final url = Uri.parse('$baseUrl/movie/upcoming?api_key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to fetch upcoming movies');
    }
  }

  // Fetch Movie Details
  Future<Map<String, dynamic>> fetchMovieDetails(int movieId) async {
    final url = Uri.parse(
        '$baseUrl/movie/$movieId?api_key=$apiKey&append_to_response=credits');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch movie details');
    }
  }

  // Search Movies by Query
  Future<List<dynamic>> searchMovies(String query) async {
    final url = Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to fetch search results');
    }
  }
}
