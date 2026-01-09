import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/screen/details_screens/ApartmentDetails_screen.dart';
import 'package:daleel_app_project/widget/apartment_widgets/favorite_widget.dart';
import 'package:flutter/material.dart';

class HighlyRatedApartmentCard extends StatelessWidget {
  const HighlyRatedApartmentCard({super.key, required this.apartment});

  final Apartments2 apartment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SizedBox(
      width: 230,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ApartmentDetailsScreen(apartment: apartment),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: apartment.images.isNotEmpty
                          ? Image.network(
                              apartment.images[0],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                    "assets/images/user.png",
                                    fit: BoxFit.cover,
                                  ),
                            )
                          : Image.asset(
                              "assets/images/user.png",
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 4,
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: colorScheme.surface.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      child: FavoriteWidget(apartment: apartment),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.onSurface.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            apartment.averageRating?.toStringAsFixed(1) ??
                                'N/A',
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            apartment.headDescription ??
                                AppLocalizations.of(context)!.noDescription,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '${apartment.rentFee ?? 'N/A'}\$ / ${AppLocalizations.of(context)!.day}',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: colorScheme.onSurface.withOpacity(0.7),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            apartment.location?['city'] ??
                                AppLocalizations.of(context)!.unknownCity,
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurface.withOpacity(0.7),
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
