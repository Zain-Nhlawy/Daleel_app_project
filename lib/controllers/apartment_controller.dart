import '../models/apartments.dart';
import '../services/apartment_service.dart';

class ApartmentController {
  final ApartmentService apartmentService;

  ApartmentController({required this.apartmentService});

  Apartments2? _apartment;
  Apartments2? get apartment => _apartment;

  Future<Apartments2?> fetchApartment(int id) async {
    try {
      final fetchedApartment = await apartmentService.getApartment(id);
      if (fetchedApartment != null) {
        _apartment = fetchedApartment;
        return _apartment;
      }
    } catch (e) {
      print('Error in fetchApartment: $e');
    }
    return null;
  }

  List<Apartments2>? _apartments;
  List<Apartments2>? get apartments => _apartments;
  Future<List<Apartments2>?> loadApartments() async {
    try {
      final apartments = await apartmentService.getApartments();
      _apartments = apartments;
      return _apartments  ;
    } catch (e) {
      rethrow;
    }
  }

  void clearApartment() {
    _apartment = null;
  }
}
