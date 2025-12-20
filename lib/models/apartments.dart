import 'package:daleel_app_project/models/comment.dart';
import 'package:daleel_app_project/models/user.dart';

const String BASE_URL = "http://10.47.171.209:8000";

class Apartments2 {
  final int id;
  final User user;
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
  List<Map<String, dynamic>>? freeTimes;
  List<Comment>? comments;

  Apartments2({
    required this.id,
    required this.user,
    this.description,
    this.headDescription,
    this.area,
    this.location,
    this.freeTimes,
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
    id: json['id'] ?? 0,

    user: json['user'] != null
        ? User.fromJson(json['user'])
        : User.empty(), 

    description: json['description'],
    headDescription: json['headDescription'],

    area: json['area'] != null
        ? double.tryParse(json['area'].toString())
        : null,

    location: json['location'] != null && json['location'] is Map
        ? Map<String, dynamic>.from(json['location'])
        : null,

    freeTimes: json['free_times'] is List
        ? List<Map<String, dynamic>>.from(
            json['free_times'].map((ft) => {
              'start_time': ft?['start_time'] ?? '__',
              'end_time': ft?['end_time'] ?? '__',
            }),
          )
        : [],

    rentFee: json['rentFee'] != null
        ? double.tryParse(json['rentFee'].toString())
        : null,

    isAvailable: json['isAvailable'] != null
        ? json['isAvailable'].toString() == '1'
        : null,

    status: json['status'],

    bedrooms: json['bedrooms'] != null
        ? int.tryParse(json['bedrooms'].toString())
        : null,

    bathrooms: json['bathrooms'] != null
        ? int.tryParse(json['bathrooms'].toString())
        : null,

    floor: json['floor'] != null
        ? int.tryParse(json['floor'].toString())
        : null,

    averageRating: json['average_rating'] != null
        ? double.tryParse(json['average_rating'].toString())
        : null,

    reviewCount: json['review_count'] != null
        ? int.tryParse(json['review_count'].toString())
        : null,

    images: json['images'] is List
        ? List<String>.from(
            json['images'].map((img) => "$BASE_URL$img"),
          )
        : [],

    comments: json['comments'] is List
        ? List<Comment>.from(
            json['comments'].map((c) => Comment.fromJson(c)),
          )
        : [],
  );
}

}
