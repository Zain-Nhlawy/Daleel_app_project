
import 'package:daleel_app_project/models/apartments.dart';
import 'package:equatable/equatable.dart';

class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesLoaded extends FavoritesState {
  final List<Apartments2> apartments;
  const FavoritesLoaded(this.apartments);

  @override
  List<Object?> get props => [apartments];
}

class FavoritesLoading extends FavoritesState {
  
}

class FavoritesError extends FavoritesState {
  final String message;
  const FavoritesError(this.message);

  @override
  List<Object?> get props => [message];
}