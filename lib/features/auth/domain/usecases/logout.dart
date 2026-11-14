import '../repositories/auth_repository.dart';

class Logout {
  Logout(this.repository);

  final AuthRepository repository;

  Future<void> call() => repository.logout();
}
