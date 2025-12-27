import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/screen/chats_sceens/chat_screen.dart';
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
    final Color textColor = theme.colorScheme.onSurface;

    ImageProvider _getUserImage(String? img) {
      if (img == null || img.isEmpty)
        return const AssetImage('assets/images/user.png');
      if (img.startsWith('http')) return NetworkImage(img);
      return NetworkImage('$baseUrl$img');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.publishedBy,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            CircleAvatar(radius: 28, backgroundImage: _getUserImage(img)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '${apartment.user.firstName} ${apartment.user.lastName}',
                style: theme.textTheme.bodyMedium?.copyWith(color: textColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            CustomButton(
              text: AppLocalizations.of(context)!.contactUs,
              bordered: true,
              color: theme.colorScheme.primary,
              textColor: theme.colorScheme.primary,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      receiverId: apartment.user.userId.toString(),
                      receiverName:
                          "${apartment.user.firstName} ${apartment.user.lastName}",
                      receiverImage: apartment.user.profileImage,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
