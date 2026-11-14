import '../../../../core/models/movie_model.dart';
import '../repositories/favorite_repository.dart';

class GetFavorites {
  GetFavorites(this.repository);

  final FavoriteRepository repository;

  List<MovieModel> call() => repository.getFavorites();
}
