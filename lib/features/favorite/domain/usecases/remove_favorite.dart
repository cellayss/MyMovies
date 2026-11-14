import '../repositories/favorite_repository.dart';

class RemoveFavorite {
  RemoveFavorite(this.repository);

  final FavoriteRepository repository;

  Future<void> call(int movieId) => repository.removeFavorite(movieId);
}
