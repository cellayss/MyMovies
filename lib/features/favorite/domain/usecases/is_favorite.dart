import '../repositories/favorite_repository.dart';

class IsFavorite {
  IsFavorite(this.repository);

  final FavoriteRepository repository;

  bool call(int movieId) => repository.isFavorite(movieId);
}
