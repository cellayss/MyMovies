import 'package:flutter/material.dart';

import '../../../../core/models/genre_model.dart';
import '../../../../core/models/movie_model.dart';
import '../../../../core/repositories/movie_repository_impl.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider(this._repository);

  final MovieRepositoryImpl _repository;

  List<MovieModel> nowPlayingMovies = [];
  List<MovieModel> trendingMovies = [];
  List<GenreModel> genres = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadHome() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _repository.getNowPlayingMovies(),
        _repository.getTrendingMovies(),
        _repository.getGenres(),
      ]);

      nowPlayingMovies = results[0] as List<MovieModel>;
      trendingMovies = results[1] as List<MovieModel>;
      genres = results[2] as List<GenreModel>;
    } catch (error) {
      errorMessage = error.toString();
      print('❌ ERROR DETAIL: $error'); // tambah ini
    }

    isLoading = false;
    notifyListeners();
  }
}
