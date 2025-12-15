import 'package:daleel_app_project/models/apartments2.dart';
import 'package:daleel_app_project/services/apartment_service.dart';
import '../core/storage/secure_storage.dart';

class ApartmentController {
  final ApartmentService apartmentsService;
  final AppSecureStorage storage;
  ApartmentController({required this.apartmentsService, required this.storage});
  List<Apartments2>? _apartments;
  List<Apartments2>? get apartments => _apartments;
  Future<List<Apartments2>?> loadApartments() async {
    try {
      final apartments = await apartmentsService.getApartments();
      _apartments = apartments;
      return _apartments  ;
    } catch (e) {
      rethrow;
    }
  }
}
