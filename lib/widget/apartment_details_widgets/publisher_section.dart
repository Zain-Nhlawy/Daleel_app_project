import 'package:flutter/material.dart';
import '../../models/apartments.dart';
import '../custom_button.dart';

class PublisherSection extends StatelessWidget {
  final Apartments2 apartment;
  final ThemeData theme;

  const PublisherSection({
    super.key,
    required this.apartment,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final img = apartment.user.profileImage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Published By",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: img.startsWith('http')
                      ? NetworkImage(img)
                      : NetworkImage('http://10.0.2.2:8000$img'),
            ),
            const SizedBox(width: 12),
            Text(
              '${apartment.user.firstName} ${apartment.user.lastName}',
            ),
            const Spacer(),
            CustomButton(
              text: "Contact Us",
              bordered: true,
              color: theme.colorScheme.primary,
              textColor: theme.colorScheme.primary,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
