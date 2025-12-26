import 'package:daleel_app_project/models/user.dart';

class Review {
  final int id;
  final int rating;
  final String? createdAt;
  final String? updatedAt;
  final User? user;

  Review({
    required this.id,
    required this.rating,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      rating: json['rating'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}
