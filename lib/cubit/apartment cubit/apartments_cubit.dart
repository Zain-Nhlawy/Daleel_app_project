import 'package:daleel_app_project/cubit/apartment%20cubit/apartments_state.dart';
import 'package:daleel_app_project/services/apartment_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApartmentsCubit extends Cubit<ApartmentState> {
  final ApartmentService apartmentService;

  ApartmentsCubit(this.apartmentService) : super(ApartmentInitial());

  Future<void> loadApartments() async {
    emit(ApartmentLoading());
    try {
      final apartments = await apartmentService.getApartments();
      if (apartments.isEmpty) {
        emit(ApartmentError("No Apartment Found"));
      } else {
        emit(ApartmentLoaded(apartments));
      }
    } catch (e) {
      emit(ApartmentError("No Apartment Found"));
    }
  }

  Future<void> loadMyApartments(int id) async {
       emit(ApartmentLoading());
    try {
      final apartments = await apartmentService.getMyApartment(id);
      if (apartments.isEmpty) {
        emit(ApartmentError("No Apartment Found"));
      } else {
        emit(ApartmentLoaded(apartments));
      }
    } catch (e) {
      emit(ApartmentError("No Apartment Found"));
    }
  }

}
