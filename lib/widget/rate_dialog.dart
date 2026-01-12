import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

Future<bool?> showRatingDialog(BuildContext context, int dep_id) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return StarRatingDialog(department_id: dep_id);
    },
  );
}

class StarRatingDialog extends StatefulWidget {
  final int department_id;
  const StarRatingDialog({super.key, required this.department_id});

  @override
  State<StarRatingDialog> createState() => _StarRatingDialogState();
}

class _StarRatingDialogState extends State<StarRatingDialog> {
  late int dedepartment_id = widget.department_id;
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final starColor =
        theme.colorScheme.secondary; // Theme-adaptive "star" color

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: starColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.star_rounded, color: starColor, size: 40),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.ratetheDepartment,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.pleaseselectthenumberofstars,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () => setState(() => _rating = index + 1),
                  style: IconButton.styleFrom(
                    padding: const EdgeInsets.all(4),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  icon: Icon(
                    index < _rating
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: index < _rating
                        ? starColor
                        : theme.colorScheme.outline.withOpacity(0.4),
                    size: 38,
                  ),
                );
              }),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      foregroundColor: theme.colorScheme.onSurface.withOpacity(
                        0.7,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(AppLocalizations.of(context)!.cancel),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: _rating == 0
                        ? null
                        : () async {
                            await reviewController.addReview(
                              dedepartment_id,
                              _rating,
                            );
                            if (context.mounted) {
                              Navigator.pop(context, true);
                            }
                          },
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.submit,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
