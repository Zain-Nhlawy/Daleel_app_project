import 'package:daleel_app_project/models/user.dart';

class Comment {
  final int id;
  final String content;
  final int userId;
  final int departmentId;
  final User? user;

  Comment({
    required this.id,
    required this.content,
    required this.userId,
    required this.departmentId,
    this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      userId: json['user_id'],
      departmentId: json['department_id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}
