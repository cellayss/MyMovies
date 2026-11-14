import '../../../../core/models/movie_model.dart';
import '../../../../core/repositories/movie_repository_impl.dart';

class GetMoviesByGenre {
  GetMoviesByGenre(this.repository);

  final MovieRepositoryImpl repository;

  Future<List<MovieModel>> call(int genreId) {
    return repository.getMoviesByGenre(genreId);
  }
}
