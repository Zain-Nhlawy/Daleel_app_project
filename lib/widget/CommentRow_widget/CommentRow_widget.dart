import 'package:flutter/material.dart';

class CommentRowWidget extends StatelessWidget {
  final String userName;
  final String userImage;
  final String comment;
  final ThemeData theme;

  const CommentRowWidget({super.key, required this.userName, required this.userImage, required this.comment, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 22, backgroundImage: AssetImage(userImage)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(comment, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}
