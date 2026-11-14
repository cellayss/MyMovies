import 'package:flutter/material.dart';

import '../../../../core/storage/local_storage.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._storage);

  final LocalStorage _storage;

  Future<void> login() async {
    await _storage.setBool(LocalStorageKeys.isLoggedIn, true);
  }

  Future<void> logout() async {
    await _storage.setBool(LocalStorageKeys.isLoggedIn, false);
  }

  bool get isLoggedIn {
    return _storage.getBool(LocalStorageKeys.isLoggedIn) ?? false;
  }
}
