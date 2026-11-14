import '../repositories/auth_repository.dart';

class Login {
  Login(this.repository);

  final AuthRepository repository;

  Future<void> call() => repository.login();
}
