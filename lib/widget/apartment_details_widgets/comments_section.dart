import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../models/comment.dart';
import '../custom_button.dart';
import '../custom_text_field.dart';

class CommentsSection extends StatelessWidget {
  final List<Comment> comments;
  final bool showAll;
  final ThemeData theme;
  final TextEditingController controller;
  final VoidCallback onToggleShow;
  final VoidCallback onSend;

  const CommentsSection({
    super.key,
    required this.comments,
    required this.showAll,
    required this.theme,
    required this.controller,
    required this.onToggleShow,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.comments,
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        if (comments.isEmpty)
          Text(AppLocalizations.of(context)!.noCommentsYet),

        Column(
        children: [
          for (int i = 0;
              i < (showAll ? comments.length : comments.length.clamp(0, 3));
              i++) ...[
            _commentRow(comment: comments[i], theme: theme),
            if (i < comments.length - 1)
              Divider(color: Colors.grey.shade300),
          ]
        ],
      ),

        if (comments.length > 3)
          Center(
            child: TextButton(
              onPressed: onToggleShow,
              child: Text(
                showAll ? AppLocalizations.of(context)!.showLess : AppLocalizations.of(context)!.showMore,
                style: TextStyle(color: theme.colorScheme.primary),
              ),
            ),
          ),


        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: controller,
                label: "",
                hint: AppLocalizations.of(context)!.addAComment,
                icon: Icons.comment,
                readOnly: false,
                borderColor: Colors.brown,
              ),
            ),
            const SizedBox(width: 8),
            CustomButton(
              text: AppLocalizations.of(context)!.send,
              bordered: true,
              color: theme.colorScheme.primary,
              textColor: theme.colorScheme.primary,
              onPressed: onSend,
            ),
          ],
        ),
      ],
    );
  }

  ImageProvider _getProfileImage(String? image) {
    if (image == null || image.isEmpty) return const AssetImage('assets/images/user.png');

    if (image.startsWith('http')) return NetworkImage(image);

    if (image.contains('https://')) {
      final fixedUrl = image.replaceFirst('/storage/', '');
      return NetworkImage(fixedUrl);
    }

    return NetworkImage('http://10.0.2.2:8000$image');
  }

  Widget _commentRow({
    required Comment comment,
    required ThemeData theme,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundImage: _getProfileImage(comment.user?.profileImage),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${comment.user?.firstName ?? ''} ${comment.user?.lastName ?? ''}",
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(comment.content),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
