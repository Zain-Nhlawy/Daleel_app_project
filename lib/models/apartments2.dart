import 'package:daleel_app_project/models/comment.dart';

const String BASE_URL = "http://10.0.2.2:8000";

class Apartments2 {
  final int id;
  final int? userId;
  final String? description;
  final String? headDescription;
  final double? area;
  final Map<String, dynamic>? location;
  final double? rentFee;
  final bool? isAvailable;
  final String? status;
  final int? bedrooms;
  final int? bathrooms;
  final int? floor;
  final double? averageRating;
  final int? reviewCount;
  final List<String>? images;
  final List<Comment>? comments;

  Apartments2({
    required this.id,
    this.userId,
    this.description,
    this.headDescription,
    this.area,
    this.location,
    this.rentFee,
    this.isAvailable,
    this.status,
    this.bedrooms,
    this.bathrooms,
    this.floor,
    this.averageRating,
    this.reviewCount,
    this.images,
    this.comments,
  });

 factory Apartments2.fromJson(Map<String, dynamic> json) {
  return Apartments2(
    id: json['id'],
    userId: json['user_id'] != null
        ? int.tryParse(json['user_id'].toString())
        : null,

    description: json['description'],
    headDescription: json['headDescription'],

    area: json['area'] != null
        ? double.tryParse(json['area'].toString())
        : null,

    location: json['location'],

    rentFee: json['rentFee'] != null
        ? double.tryParse(json['rentFee'].toString())
        : null,

    isAvailable: int.parse(json['isAvailable'].toString()) == 1,

    status: json['status'],

    bedrooms: int.parse(json['bedrooms'].toString()),
    bathrooms: int.parse(json['bathrooms'].toString()),

    floor: json['floor'] != null
        ? int.tryParse(json['floor'].toString())
        : null,

    averageRating: json['average_rating'] != null
        ? double.tryParse(json['average_rating'].toString())
        : null,

    reviewCount: json['review_count'] != null
        ? int.tryParse(json['review_count'].toString())
        : null,

    images: json['images'] != null
        ? List<String>.from(json['images'].map((img) => "$BASE_URL$img"))
        : [],

    comments: json['comments'] != null
        ? List<Comment>.from(
            json['comments'].map((c) => Comment.fromJson(c)),
          )
        : [],
  );
}

}
