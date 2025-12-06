import 'package:daleel_app_project/models/user.dart';

class Comment {
  User user;
  String text;
  Comment({
    required this.user,
    required this.text
  });
}