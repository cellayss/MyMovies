import 'dart:convert';

import '../../../../core/models/movie_model.dart';
import '../../../../core/storage/local_storage.dart';

class FavoriteLocalDatasource {
  FavoriteLocalDatasource(this._storage);

  final LocalStorage _storage;

  List<MovieModel> getFavorites() {
    final items = _storage.getStringList(LocalStorageKeys.favoriteMovies);
    return items.map((item) => MovieModel.fromJson(jsonDecode(item))).toList();
  }

  Future<void> saveFavorites(List<MovieModel> movies) {
    final items = movies.map((movie) => jsonEncode(movie.toJson())).toList();
    return _storage.setStringList(LocalStorageKeys.favoriteMovies, items);
  }
}
