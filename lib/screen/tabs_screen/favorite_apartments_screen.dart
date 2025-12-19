import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/widget/apartment_widgets/nearpy_apartments_widgets.dart';
import 'package:flutter/material.dart';

class FavoriteApartmentsScreen extends StatefulWidget {
  const FavoriteApartmentsScreen({super.key});

  @override
  State<FavoriteApartmentsScreen> createState() =>
      _FavoriteApartmentsScreenState();
}

class _FavoriteApartmentsScreenState extends State<FavoriteApartmentsScreen> {
  late Future<List<Apartments2>?> _myApartmentsFuture;

  void initState() {
    super.initState();
    _myApartmentsFuture = apartmentController.loadMyApartments(9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Favorites', style: Theme.of(context).textTheme.bodyLarge),
        centerTitle: true,
      ),
      body:  FutureBuilder<List<Apartments2>?>(
        future: _myApartmentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No apartments found'));
          }
          final apartments = snapshot.data!;
          return ListView.builder(
            itemCount: apartments.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: NearpyApartmentsWidgets(apartment: apartments[index]),
              );
            },
          );
        },
      ),
    );
  }
}
