class Apartments {
  final String apartmentHeadDescripton; 
  final String apartmentCountry;
  final double apartmentRate;
  final double price;
  final int floor;
  final int bedrooms;
  final int bathrooms;
  final int area;
  final String publisherName;

  final String apartmentPicture; 
  final List<String> apartmentPictures; 
  final String description; 

  final List<String> comments; 

  Apartments({
    required this.apartmentHeadDescripton,
    required this.apartmentCountry,
    required this.apartmentRate,
    required this.price,
    required this.floor,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.publisherName,
    required this.apartmentPicture,
    this.apartmentPictures = const [],
    this.description = "",
    this.comments = const [],
  });
}
