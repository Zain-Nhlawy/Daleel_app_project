import '../models/apartments.dart';
import '../services/apartment_service.dart';

class ApartmentController {
  final ApartmentService apartmentService;

  ApartmentController({required this.apartmentService});

  Apartments2? _apartment;
  Apartments2? get apartment => _apartment;

  Apartments2? _favoriteApartment;
  Apartments2? get favoriteApartment => _favoriteApartment;

  Future<Apartments2?> fetchApartment(int id) async {
    try {
      final fetchedApartment = await apartmentService.getApartment(id);
      if (fetchedApartment != null) {
        _apartment = fetchedApartment;
        return _apartment;
      }
    } catch (e) {}
    return null;
  }

  List<Apartments2>? _apartments;
  List<Apartments2>? get apartments => _apartments;

  Future<List<Apartments2>?> loadApartments() async {
    try {
      final apartments = await apartmentService.getApartments();
      _apartments = apartments;
      return _apartments;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Apartments2>?> loadMyApartments(int id) async {
    try {
      final apartments = await apartmentService.getMyApartment(id);
      _apartments = apartments;
      return _apartments;
    } catch (e) {
      rethrow;
    }
  }

  void clearApartment() {
    _apartment = null;
  }

  List<Apartments2>? _favouriteApartments;
  List<Apartments2>? get favouriteApartments => _favouriteApartments;

  Future<List<Apartments2>?> loadFavouriteApartments() async {
    try {
      final apartments = await apartmentService.getFavouriteApartments();
      _favouriteApartments = apartments;
      return _favouriteApartments;
    } catch (e) {
      rethrow;
    }
  }

  // In your ApartmentController

Future<List<Apartments2>?> loadFilteredApartments({
  String? governorate, // Changed to nullable
  int? bedrooms,      // Changed to nullable
  int? bathrooms,     // Changed to nullable
  double? minArea,   // Changed to nullable
  double? maxArea,   // Changed to nullable
  double? minPrice,  // Changed to nullable
  double? maxPrice,   // Changed to nullable
}) async {
  try {
    // Pass the nullable values down to the service
    final apartments = await apartmentService.getFilteredApartments(
      governorate: governorate,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      minArea: minArea,
      maxArea: maxArea,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
    _favouriteApartments = apartments; // Assuming this is correct
    return _favouriteApartments;
  } catch (e) {
    print("Error in controller: $e");
    rethrow;
  }
}

}
