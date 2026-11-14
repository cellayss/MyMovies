import '../../core/network/api_client.dart';
import '../../core/repositories/movie_repository_impl.dart';
import '../../core/storage/local_storage.dart';
import '../../features/home/presentation/providers/home_provider.dart';

final Map<Type, Object> _instances = {};

T sl<T extends Object>() => _instances[T] as T;

Future<void> setupServiceLocator() async {
  final localStorage = await LocalStorage.create();
  final apiClient = ApiClient();
  final movieRepository = MovieRepositoryImpl(apiClient);

  _instances[LocalStorage] = localStorage;
  _instances[ApiClient] = apiClient;
  _instances[MovieRepositoryImpl] = movieRepository;
  _instances[HomeProvider] = HomeProvider(movieRepository);
}