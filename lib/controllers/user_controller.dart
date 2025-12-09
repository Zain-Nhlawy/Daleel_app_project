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

  if (loggedUser == null) {
    return null;          
  }

  _user = loggedUser;     
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
  required String location,
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
    'location': location,
  });

  final registeredUser = await userService.register(formData);

  if (registeredUser != null) {
    _user = registeredUser;
  }

  return _user;
}

  Future<void> logout() async {
    try {
      final success = await userService.logout(); 
      if (success) {
        _user = null; 
      } else {
        print("Logout failed on server");
      }
    } catch (e) {
      print("Logout error: $e");
    }
  }

  void updateProfile(User updatedUser) {
    _user = updatedUser;
  }

  bool get isLoggedIn => _user != null;
}
