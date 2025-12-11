class Location {
  final String governorate;
  final String city;
  final String district;
  final String street;

  Location({
    required this.governorate,
    required this.city,
    required this.district,
    required this.street,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      governorate: json['governorate'] ?? "",
      city: json['city'] ?? "",
      district: json['district'] ?? "",
      street: json['street'] ?? "",
    );
  }
}
