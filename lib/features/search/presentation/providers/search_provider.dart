import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../core/models/movie_model.dart';
import '../../../../core/repositories/movie_repository_impl.dart';

class SearchProvider extends ChangeNotifier {
  SearchProvider(this._repository);

  final MovieRepositoryImpl _repository;

  List<MovieModel> movies = [];
  bool isLoading = false;
  String? errorMessage;
  Timer? _debounce;

  void onSearchChanged(String query) {
    _debounce?.cancel();
    if (query.trim().isEmpty) {
      movies = [];
      isLoading = false;
      errorMessage = null;
      notifyListeners();
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      search(query);
    });
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) return;
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      movies = await _repository.searchMovies(query);
    } catch (error) {
      errorMessage = error.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}