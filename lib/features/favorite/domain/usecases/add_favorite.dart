import '../../../../core/models/movie_model.dart';
import '../repositories/favorite_repository.dart';

class AddFavorite {
  AddFavorite(this.repository);

  final FavoriteRepository repository;

  Future<void> call(MovieModel movie) => repository.addFavorite(movie);
}
