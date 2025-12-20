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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          apartment.headDescription ?? '',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              const Icon(Icons.location_on, color: Colors.red),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${apartment.location?['governorate']} / ${apartment.location?['city']}',
                ),
              ),
              const Icon(Icons.star, color: Colors.amber),
              Text(apartment.averageRating.toString()),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              const Icon(Icons.attach_money, color: Colors.green),
              const SizedBox(width: 6),
              Text(
                "${apartment.rentFee} / Day",
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
