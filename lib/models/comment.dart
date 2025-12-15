import 'package:daleel_app_project/models/user.dart';

class Comment {
  final int id;
  final String content;
  final String? createdAt;
  final String? updatedAt;
  final User? user;

  Comment({
    required this.id,
    required this.content,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}
