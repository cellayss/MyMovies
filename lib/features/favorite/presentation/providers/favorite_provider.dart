import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../core/models/movie_model.dart';
import '../../../../core/storage/local_storage.dart';

class FavoriteProvider extends ChangeNotifier {
  FavoriteProvider(this._storage) {
    loadFavorites();
  }

  final LocalStorage _storage;

  List<MovieModel> favorites = [];

  void loadFavorites() {
    final items = _storage.getStringList(LocalStorageKeys.favoriteMovies);
    favorites = items
        .map((item) => MovieModel.fromJson(jsonDecode(item)))
        .toList();
    notifyListeners();
  }

  bool isFavorite(int movieId) {
    return favorites.any((movie) => movie.id == movieId);
  }

  Future<void> toggleFavorite(MovieModel movie) async {
    if (isFavorite(movie.id)) {
      favorites.removeWhere((item) => item.id == movie.id);
    } else {
      favorites.add(movie);
    }

    final items = favorites.map((movie) => jsonEncode(movie.toJson())).toList();
    await _storage.setStringList(LocalStorageKeys.favoriteMovies, items);
    notifyListeners();
  }
}
