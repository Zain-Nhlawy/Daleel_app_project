import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/models/comment.dart';
import 'package:daleel_app_project/models/user.dart';

String BASE_URL = baseUrl;

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
  final List<String> images;
  List<Map<String, dynamic>>? freeTimes;
  List<Comment> comments;
  final bool? state;
  bool? isFavorited;

  void toggle() {
    isFavorited = (isFavorited == false ? true : false);
  }

  Apartments2({
    required this.id,
    required this.user,
    this.state,
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
    required this.images,
    required this.comments,
    this.isFavorited,
  });

  factory Apartments2.fromJson(Map<String, dynamic> json) {
    int? _safeParseInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value);
      return null;
    }

    double? _safeParseDouble(dynamic value) {
      if (value == null) return null;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value);
      return null;
    }

    List<String> parsedImages = [];
    if (json['images'] != null) {
      if (json['images'] is List) {
        parsedImages = List<String>.from(
          json['images'].map((img) {
            String imageUrl = img.toString();
            return imageUrl.startsWith('http') ? imageUrl : "$baseUrl$imageUrl";
          }),
        );
      }
    }

    return Apartments2(
      id: _safeParseInt(json['id']) ?? 0,
      state: _safeParseInt(json['verification_state']) == 1,
      user: json['user'] != null
        ? User.fromJson(json['user'])
        : User.empty(), 
      description: json['description'],
      headDescription: json['headDescription'], 
      area: _safeParseDouble(json['area']),
      location: json['location'] != null
          ? Map<String, dynamic>.from(json['location'])
          : null,
      freeTimes: json['free_times'] != null
          ? List<Map<String, dynamic>>.from(
              (json['free_times'] as List).map((ft) {
                if (ft == null) return {'start_time': '__', 'end_time': '__'};
                return {
                  'start_time': ft['start_time'] ?? '__',
                  'end_time': ft['end_time'] ?? '__',
                };
              }),
            )
          : [],
      rentFee: _safeParseDouble(json['rentFee']),
      isAvailable: _safeParseInt(json['isAvailable']) == 1,
      status: json['status'],
      bedrooms: _safeParseInt(json['bedrooms']),
      bathrooms: _safeParseInt(json['bathrooms']),
      floor: _safeParseInt(json['floor']),
      averageRating: _safeParseDouble(json['average_rating']),
      reviewCount: _safeParseInt(json['review_count']),
      images: parsedImages,
      comments: json['comments'] is List
    ? (json['comments'] as List)
        .map<Comment>((c) => Comment.fromJson(c)) 
        .toList()
    : <Comment>[],
      isFavorited: json['is_favorited'] == true,
    );
  }

  factory Apartments2.empty() {
    return Apartments2(
      id: 0,
      user: User.empty(),
      images: [],
      freeTimes: [],
      comments: [],
    );
  }
}
