import 'package:flutter/material.dart';

import '../../../../core/models/movie_model.dart';
import '../../../../core/repositories/movie_repository_impl.dart';

class GenreProvider extends ChangeNotifier {
  GenreProvider(this._repository);

  final MovieRepositoryImpl _repository;

  List<MovieModel> movies = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadByGenre(int genreId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      movies = await _repository.getMoviesByGenre(genreId);
    } catch (error) {
      errorMessage = error.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
