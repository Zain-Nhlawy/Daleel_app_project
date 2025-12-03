/*class User {
  final String name;
  final String profileImage;
  final String personIdImage;
  final String phone;
  final String email;
  final String birthdate;
  const User({
    required this.name, 
    required this.profileImage, 
    required this.personIdImage, 
    required this.phone, 
    required this.email, 
    required this.birthdate
  });
}*/

import 'package:daleel_app_project/data/me.dart';

class User {
  final String name;
  final String profileImage;
  final String personIdImage;
  final String phone;
  final String email;
  final String birthdate;
  final String? verificationState;

  const User({
    required this.name,
    required this.profileImage,
    required this.personIdImage,
    required this.phone,
    required this.email,
    required this.birthdate,
    this.verificationState,
  });

  static User fromJson(data) {
    return me;
  }
}