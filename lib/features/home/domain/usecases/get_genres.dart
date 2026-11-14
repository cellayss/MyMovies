import '../../../../core/models/genre_model.dart';
import '../../../../core/repositories/movie_repository_impl.dart';

class GetGenres {
  GetGenres(this.repository);

  final MovieRepositoryImpl repository;

  Future<List<GenreModel>> call() => repository.getGenres();
}
