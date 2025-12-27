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
    final Color iconColor = theme.colorScheme.onSurface.withOpacity(0.6);
    final Color descriptionColor = theme.colorScheme.onSurface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildInfoItem(
                icon: Icons.bed,
                iconColor: iconColor,
                value: '${apartment.bedrooms ?? 0}',
                label: AppLocalizations.of(context)!.bedrooms,
              ),
            ),
            Expanded(
              child: _buildInfoItem(
                icon: Icons.bathtub,
                iconColor: iconColor,
                value: '${apartment.bathrooms ?? 0}',
                label: AppLocalizations.of(context)!.bathrooms,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildInfoItem(
                icon: Icons.layers_outlined,
                iconColor: iconColor,
                value: '${apartment.floor ?? 0}',
                label: AppLocalizations.of(context)!.floor,
              ),
            ),
            Expanded(
              child: _buildInfoItem(
                icon: Icons.square_foot_outlined,
                iconColor: iconColor,
                value: '${apartment.area ?? 0} m²',
                label: AppLocalizations.of(context)!.area,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          AppLocalizations.of(context)!.description,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: descriptionColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          apartment.description ?? '',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: descriptionColor.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 32),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: theme.colorScheme.onSurface,
              ),
            ),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
