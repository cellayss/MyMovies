import '../../../../core/models/movie_model.dart';

abstract class FavoriteRepository {
  List<MovieModel> getFavorites();
  Future<void> addFavorite(MovieModel movie);
  Future<void> removeFavorite(int movieId);
  bool isFavorite(int movieId);
}
