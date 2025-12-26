import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/models/user.dart';
import 'package:daleel_app_project/widget/apartment_widgets/nearpy_apartments_widgets.dart';
import 'package:flutter/material.dart';

class MyHousesScreen extends StatefulWidget {
  const MyHousesScreen({super.key});

  @override
  State<MyHousesScreen> createState() =>
      _FavoriteApartmentsScreenState();
}

class _FavoriteApartmentsScreenState extends State<MyHousesScreen> {
  late Future<List<Apartments2>?> _myApartmentsFuture;
  final User? user = userController.user;
  void initState() {
    super.initState();
    _myApartmentsFuture = apartmentController.loadMyApartments(user!.userId);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myHouses, style: Theme.of(context).textTheme.bodyLarge),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Apartments2>?>(
        future: _myApartmentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('${AppLocalizations.of(context)!.error}: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(AppLocalizations.of(context)!.noApartmentsFound));
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
