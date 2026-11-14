import 'package:flutter/material.dart';

import '../../../../core/models/movie_detail_model.dart';
import '../../../../core/repositories/movie_repository_impl.dart';

class MovieDetailProvider extends ChangeNotifier {
  MovieDetailProvider(this._repository);

  final MovieRepositoryImpl _repository;

  MovieDetailModel? movie;
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadDetail(int movieId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      movie = await _repository.getMovieDetail(movieId);
    } catch (error) {
      errorMessage = error.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
