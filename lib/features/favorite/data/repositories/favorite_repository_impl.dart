import '../../../../core/models/movie_model.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../datasources/favorite_local_datasource.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  FavoriteRepositoryImpl(this._datasource);

  final FavoriteLocalDatasource _datasource;

  @override
  List<MovieModel> getFavorites() {
    return _datasource.getFavorites();
  }

  @override
  Future<void> addFavorite(MovieModel movie) async {
    final movies = getFavorites();
    if (!movies.any((item) => item.id == movie.id)) {
      movies.add(movie);
      await _datasource.saveFavorites(movies);
    }
  }

  @override
  Future<void> removeFavorite(int movieId) async {
    final movies = getFavorites()..removeWhere((item) => item.id == movieId);
    await _datasource.saveFavorites(movies);
  }

  @override
  bool isFavorite(int movieId) {
    return getFavorites().any((item) => item.id == movieId);
  }
}
