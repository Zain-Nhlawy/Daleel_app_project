import 'dart:convert';
import 'package:daleel_app_project/Cubit/favorites_state.dart';
import 'package:daleel_app_project/data/me.dart';
import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/models/apartments2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

List<Apartments2> apartments = apartmentController.apartments!;


class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesLoaded(apartments));

  Future loadFavorites(int page) async {
    emit(FavoritesLoading());
    try {
      final current = await http.get(Uri.parse("$baseURL/v1/auth/favorites/me?page=$page"),
        headers: <String, String> {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token"
        }
      );
      if(current.statusCode == 200) {
        final data = jsonDecode(current.body)['data'];
        List<Apartments2> apartments = [];
        for(final d in data) {
          apartments.add(Apartments2.fromJson(d));
        }
        emit(FavoritesLoaded(apartments));
      }
      else {
        emit(FavoritesError("status code is not 200"));
      }
    }
    catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}