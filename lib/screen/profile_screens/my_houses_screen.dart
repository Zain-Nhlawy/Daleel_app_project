import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/models/user.dart';
import 'package:daleel_app_project/widget/apartment_widgets/nearpy_apartments_widgets.dart';
import 'package:flutter/material.dart';

class MyHousesScreen extends StatefulWidget {
  const MyHousesScreen({super.key});

  @override
  State<MyHousesScreen> createState() => _FavoriteApartmentsScreenState();
}

class _FavoriteApartmentsScreenState extends State<MyHousesScreen> {
  late Future<List<Apartments2>?> _myApartmentsFuture;
  final User? user = userController.user;

  @override
  void initState() {
    super.initState();
    _myApartmentsFuture = apartmentController.loadMyApartments(user!.userId);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.myHouses,
          style: textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.background,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: FutureBuilder<List<Apartments2>?>(
            future: _myApartmentsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: colorScheme.onPrimary,
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    AppLocalizations.of(context)!.anErrorOccurred,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    AppLocalizations.of(context)!.noApartmentsFound,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                );
              }

              final apartments = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 12),
                itemCount: apartments.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: NearpyApartmentsWidgets(
                      apartment: apartments[index],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
