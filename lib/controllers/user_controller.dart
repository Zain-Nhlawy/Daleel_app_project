import '../models/user.dart';
import '../services/user_service.dart';
import '../core/storage/secure_storage.dart';
import 'package:dio/dio.dart';

class UserController {
  final UserService userService;
  final AppSecureStorage storage;

  User? _user;
  User? get user => _user;

  UserController({required this.userService, required this.storage});

  Future<User?> login(String phone, String password) async {
    final loggedUser = await userService.login(phone, password);
    if (loggedUser == null) return null;
    _user = loggedUser;
    await getProfile();
    return _user;
  }

  Future<User?> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    required String confirmPassword,
    required String profileImage,
    required String personIdImage,
    required String birthdate,
    required Map<String, dynamic> location,
  }) async {
    final profileFile = await MultipartFile.fromFile(profileImage, filename: "profile.jpg");
    final idFile = await MultipartFile.fromFile(personIdImage, filename: "id.jpg");

    final formData = FormData.fromMap({
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'password': password,
      'password_confirmation': confirmPassword,
      'profileImage': profileFile,
      'personIdImage': idFile,
      'birthdate': birthdate,
      'location[governorate]': location['governorate'],
      'location[city]': location['city'],
      'location[district]': location['district'],
      'location[street]': location['street'],
    });

    final registeredUser = await userService.register(formData);
    if (registeredUser == null) return null;
    _user = registeredUser;
    await getProfile();
    return _user;
  }

  Future<void> getProfile() async {
    if (_user == null) return;

    try {
      final updatedUser = await userService.getProfile(); 
      if (updatedUser != null) _user = updatedUser;
    } catch (e) {
      print("GetProfile error: $e");
    }
  }

  Future<void> logout() async {
    try {
      final success = await userService.logout();
      if (success) _user = null;
    } catch (e) {
      print("Logout error: $e");
    }
  }

  void updateProfile(User updatedUser) {
    _user = updatedUser;
  }

  bool get isLoggedIn => _user != null;
}
