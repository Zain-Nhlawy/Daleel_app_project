import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../models/apartments.dart';

class DescriptionSection extends StatelessWidget {
  final Apartments2 apartment;
  final ThemeData theme;

  const DescriptionSection({
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
          AppLocalizations.of(context)!.description,
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(apartment.description ?? ''),
      ],
    );
  }
}
