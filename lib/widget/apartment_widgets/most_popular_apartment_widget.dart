import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/core/network/dio_client.dart';
import 'package:daleel_app_project/core/storage/secure_storage.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/screen/details_screens/ApartmentDetails_screen.dart';
import 'package:daleel_app_project/services/apartment_service.dart';
import 'package:flutter/material.dart';

class MostPopularApartmentWidget extends StatefulWidget {
  const MostPopularApartmentWidget({super.key, required this.apartment});
  final Apartments2 apartment;

  @override
  State<MostPopularApartmentWidget> createState() =>
      _MostPopularApartmentWidgetState();
}

class _MostPopularApartmentWidgetState
    extends State<MostPopularApartmentWidget> {
  late bool? _isFavorited = widget.apartment.isFavorited;
  bool _isLoading = false;

  void _handleFavoriteToggle() async {
    setState(() => _isFavorited = !_isFavorited!);

    final apartmentService = ApartmentService(
      apiClient: DioClient(storage: AppSecureStorage()),
    );
    try {
      final bool success = await apartmentService.toggleFavorite(
        widget.apartment.id,
      );
      if (!success && mounted) {
        setState(() => _isFavorited = !_isFavorited!);
      }
    } catch (_) {
      if (mounted) setState(() => _isFavorited = !_isFavorited!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  ApartmentDetailsScreen(apartment: widget.apartment),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image + Favorite Button
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: SizedBox(
                    height: 110,
                    width: double.infinity,
                    child: widget.apartment.images.isNotEmpty
                        ? Image.network(
                            widget.apartment.images[0],
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Image.asset(
                              "assets/images/user.png",
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            "assets/images/user.png",
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: scheme.surface.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: _isLoading
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              color: scheme.primary,
                            ),
                          )
                        : IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: Icon(
                              _isFavorited!
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: _isFavorited!
                                  ? scheme.error
                                  : scheme.onSurface,
                              size: 22,
                            ),
                            onPressed: _handleFavoriteToggle,
                          ),
                  ),
                ),
              ],
            ),
            // Info Section
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.apartment.headDescription ??
                              AppLocalizations.of(context)!.noDescription,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: scheme.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${widget.apartment.rentFee ?? 'N/A'}\$ / ${AppLocalizations.of(context)!.day}',
                        style: textTheme.bodySmall?.copyWith(
                          color: scheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: scheme.onSurface.withOpacity(0.7),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.apartment.location?['city'] ??
                              AppLocalizations.of(context)!.unknownCity,
                          style: textTheme.bodySmall?.copyWith(
                            color: scheme.onSurface.withOpacity(0.7),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Rating
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        widget.apartment.averageRating?.toStringAsFixed(1) ??
                            'N/A',
                        style: textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: scheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
