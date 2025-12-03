import 'package:daleel_app_project/Cubit/favorites_cubit.dart';
import 'package:daleel_app_project/Cubit/favorites_state.dart';
import 'package:daleel_app_project/widget/apartment_widgets/nearpy_apartments_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteApartmentsScreen extends StatelessWidget {
  const FavoriteApartmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<FavoritesCubit>().loadFavorites(1);
    return Scaffold(
        appBar: AppBar(
          title: Text('Favorites', style: Theme.of(context).textTheme.bodyLarge),
          centerTitle: true,
        ),
        body: BlocBuilder<FavoritesCubit, FavoritesState> (
          builder: (context, state) {
            if(state is FavoritesError) {
              return Center(child: Text(state.message));
            }
            if(state is FavoritesLoading) {
              return Center(child: Text("Loading..."));
            }
            if(state is FavoritesLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.apartments.length,
                itemBuilder: (context, index) =>
                    NearpyApartmentsWidgets(apartment: state.apartments[index]),
              );
            }
            return Text("Hello");
          }
        ) 
      );
  }
}
