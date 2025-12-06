import '../models/user.dart';
import '../services/user_service.dart';
import '../core/storage/secure_storage.dart';
import '../core/storage/storage_keys.dart';

class UserController {
  final UserService userService;
  final AppSecureStorage storage;

  User? _user;
  User? get user => _user;

  UserController({required this.userService, required this.storage});

  Future<User?> login(String phone, String password) async {
    final loggedUser = await userService.login(phone, password);
    if (loggedUser != null) {
      _user = loggedUser;
    }
    return _user;
  }

  Future<void> logout() async {
    _user = null;
    await storage.delete(StorageKeys.token);
  }

  void updateProfile(User updatedUser) {
    _user = updatedUser;
  }

  bool get isLoggedIn => _user != null;
}
