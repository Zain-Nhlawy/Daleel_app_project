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

  Future<List<Apartments2>?> loadFavouriteApartments(int page) async {
    try {
      final apartments = await apartmentService.getFavouriteApartments(page);
      _favouriteApartments = apartments;
      return _favouriteApartments;
    } catch (e) {
      rethrow;
    }
  }



Future<List<Apartments2>?> loadFilteredApartments(int page, {
  String? governorate,
  int? bedrooms,    
  int? bathrooms,    
  double? minArea, 
  double? maxArea,   
  double? minPrice, 
  double? maxPrice,  
  String? sort
}) async {
  try {
    final apartments = await apartmentService.getFilteredApartments(
      page,
      governorate: governorate,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      minArea: minArea,
      maxArea: maxArea,
      minPrice: minPrice,
      maxPrice: maxPrice,
      sort: sort
    );
    _favouriteApartments = apartments;
    return _favouriteApartments;
  } catch (e) {
    print("Error in controller: $e");
    rethrow;
  }
}

  List<Apartments2>? _searchedApartment;
  List<Apartments2>? get searchedApartment => _searchedApartment;

  Future<List<Apartments2>?> loadSearchedApartments(String search) async {
    try {
      final searchedApartment = await apartmentService.getSearchedApartments(search);
      _searchedApartment = searchedApartment;
      return _searchedApartment;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateFavoriteApartments(int id) async {
    try {
      bool sucess = await apartmentService.toggleFavorite(id);
      return sucess;
    }
    catch (e) {
      rethrow;
    }
  }

}
