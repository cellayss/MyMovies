import '../repositories/auth_repository.dart';

class CheckLoginStatus {
  CheckLoginStatus(this.repository);

  final AuthRepository repository;

  bool call() => repository.checkLoginStatus();
}
