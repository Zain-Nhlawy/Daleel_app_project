import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../models/apartments.dart';

class ApartmentInfoSection extends StatelessWidget {
  final Apartments2 apartment;
  final ThemeData theme;

  const ApartmentInfoSection({
    super.key,
    required this.apartment,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = theme.colorScheme.onSurface;
    final Color subTextColor = textColor.withOpacity(0.7);
    final Color locationIconColor = theme.colorScheme.error;
    final Color ratingIconColor =
        Colors.amber; // can be kept amber for familiarity
    final Color priceIconColor =
        Colors.green; // can keep green, or theme.primary

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          apartment.headDescription ?? '',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Icon(Icons.location_on, color: locationIconColor),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${apartment.location?['governorate']} / ${apartment.location?['city']}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: subTextColor,
                  ),
                ),
              ),
              Icon(Icons.star, color: ratingIconColor),
              const SizedBox(width: 4),
              Text(
                apartment.averageRating.toString(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: subTextColor,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Icon(Icons.attach_money, color: priceIconColor),
              const SizedBox(width: 6),
              Text(
                "${apartment.rentFee} / ${AppLocalizations.of(context)!.day}",
                style: theme.textTheme.bodyMedium?.copyWith(color: textColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
