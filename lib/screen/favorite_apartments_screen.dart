import 'package:daleel_app_project/data/dummy_data.dart';
import 'package:daleel_app_project/widget/apartment_widgets/nearpy_apartments_widgets.dart';
import 'package:flutter/material.dart';

class FavoriteApartmentsScreen extends StatelessWidget {
  const FavoriteApartmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites', style: Theme.of(context).textTheme.bodyLarge),
        centerTitle: true,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: apartmentsList.length,
        itemBuilder: (context, index) =>
            NearpyApartmentsWidgets(apartment: apartmentsList[index]),
      ),
    );
  }
}
