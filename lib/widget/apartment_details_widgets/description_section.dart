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
        Row(
          children: [
            Expanded(
              child: _buildInfoItem(
                icon: Icons.bed,
                iconColor: Colors.grey,
                value: '${apartment.bedrooms ?? 0}',
                label: 'Bedroom',
              ),
            ),
            
            Expanded(
              child: _buildInfoItem(
                icon: Icons.bathtub,
                iconColor: Colors.grey,
                value: '${apartment.bathrooms ?? 0}',
                label: 'Bathroom',
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
                iconColor: Colors.grey,
                value: '${apartment.floor ?? 0}',
                label: 'Floor',
              ),
            ),
            
            Expanded(
              child: _buildInfoItem(
                icon: Icons.square_foot_outlined,
                iconColor: Colors.grey,
                value: '${apartment.area ?? 0} m²',
                label: 'Area',
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
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
              ),
            ),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}