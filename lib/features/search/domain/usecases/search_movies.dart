import '../../../../core/models/movie_model.dart';
import '../../../../core/repositories/movie_repository_impl.dart';

class SearchMovies {
  SearchMovies(this.repository);

  final MovieRepositoryImpl repository;

  Future<List<MovieModel>> call(String query) => repository.searchMovies(query);
}
