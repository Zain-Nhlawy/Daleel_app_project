import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/widget/apartment_widgets/highly_rated_apartment_card.dart';
import 'package:flutter/material.dart';

class HighlyRatedApartmentsList extends StatefulWidget {
  const HighlyRatedApartmentsList({super.key});

  @override
  State<HighlyRatedApartmentsList> createState() =>
      _HighlyRatedApartmentsListState();
}

class _HighlyRatedApartmentsListState extends State<HighlyRatedApartmentsList> {
  late Future<List<Apartments2>?> _apartmentsFuture;

  @override
  void initState() {
    super.initState();
    _apartmentsFuture = apartmentController.loadFilteredApartments(
      1,
      sort: "rentcounter_desc",
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SizedBox(
      height: 180,
      child: FutureBuilder<List<Apartments2>?>(
        future: _apartmentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${AppLocalizations.of(context)!.error}: ${"error fetching apartment"}',
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.noApartmentsFound,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onBackground.withOpacity(0.7),
                ),
              ),
            );
          }

          final apartments = snapshot.data!;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: apartments.length,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemBuilder: (context, index) {
              final apartment = apartments[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: HighlyRatedApartmentCard(apartment: apartment),
              );
            },
          );
        },
      ),
    );
  }
}
