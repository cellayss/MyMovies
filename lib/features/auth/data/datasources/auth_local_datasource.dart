import '../../../../core/storage/local_storage.dart';

class AuthLocalDatasource {
  AuthLocalDatasource(this._storage);

  final LocalStorage _storage;

  Future<void> login() {
    return _storage.setBool(LocalStorageKeys.isLoggedIn, true);
  }

  Future<void> logout() {
    return _storage.setBool(LocalStorageKeys.isLoggedIn, false);
  }

  bool checkLoginStatus() {
    return _storage.getBool(LocalStorageKeys.isLoggedIn) ?? false;
  }
}
