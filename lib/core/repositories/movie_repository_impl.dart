import '../models/genre_model.dart';
import '../models/movie_detail_model.dart';
import '../models/movie_model.dart';
import '../network/api_client.dart';

class MovieRepositoryImpl {
  MovieRepositoryImpl(this._apiClient);

  final ApiClient _apiClient;

  Future<List<MovieModel>> getNowPlayingMovies() async {
    final data = await _apiClient.get('/movie/now_playing');
    return _parseMovies(data);
  }

  Future<List<MovieModel>> getTrendingMovies() async {
    final data = await _apiClient.get('/trending/movie/day');
    return _parseMovies(data);
  }

  Future<List<MovieModel>> searchMovies(String query) async {
    if (query.trim().isEmpty) return [];
    final data = await _apiClient.get(
      '/search/movie',
      queryParameters: {'query': query},
    );
    return _parseMovies(data);
  }

  Future<List<MovieModel>> getMoviesByGenre(int genreId) async {
    final data = await _apiClient.get(
      '/discover/movie',
      queryParameters: {'with_genres': genreId},
    );
    return _parseMovies(data);
  }

  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    final data = await _apiClient.get('/movie/$movieId');
    return MovieDetailModel.fromJson(data);
  }

  Future<List<GenreModel>> getGenres() async {
    final data = await _apiClient.get('/genre/movie/list');
    return (data['genres'] as List? ?? [])
        .map((item) => GenreModel.fromJson(item))
        .toList();
  }

  List<MovieModel> _parseMovies(Map<String, dynamic> data) {
    return (data['results'] as List? ?? [])
        .map((item) => MovieModel.fromJson(item))
        .toList();
  }
}
