import '../../../../core/models/movie_model.dart';
import '../../../../core/repositories/movie_repository_impl.dart';

class GetNowPlayingMovies {
  GetNowPlayingMovies(this.repository);

  final MovieRepositoryImpl repository;

  Future<List<MovieModel>> call() => repository.getNowPlayingMovies();
}
