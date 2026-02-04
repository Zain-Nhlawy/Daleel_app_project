  import 'package:daleel_app_project/models/apartments.dart';

abstract class ApartmentState {}

class ApartmentInitial extends ApartmentState {}

class ApartmentLoading extends ApartmentState {}

class ApartmentLoaded extends ApartmentState {
  final List<Apartments2> apartments;
  ApartmentLoaded(this.apartments);
}

class ApartmentError extends ApartmentState {
  final String message;
  ApartmentError(this.message);
}