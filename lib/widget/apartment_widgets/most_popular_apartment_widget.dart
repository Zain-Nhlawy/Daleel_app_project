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
  final bool _isLoading = false;

  void _handleFavoriteToggle() async {
    setState(() {
      _isFavorited = !_isFavorited!;
    });

    final apartmentService = ApartmentService(
      apiClient: DioClient(storage: AppSecureStorage()),
    );
    try {
      final bool success = await apartmentService.toggleFavorite(
        widget.apartment.id,
      );
      if (!success && mounted) {
        setState(() {
          _isFavorited = !_isFavorited!;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isFavorited = !_isFavorited!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF795548);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
              builder: (context) =>
                  ApartmentDetailsScreen(apartment: widget.apartment),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
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
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: _isLoading
                        ? Container(
                            width: 32,
                            height: 32,
                            padding: const EdgeInsets.all(8.0),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: Icon(
                              _isFavorited!
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: _isFavorited! ? Colors.red : Colors.white,
                              size: 22,
                            ),
                            onPressed: _handleFavoriteToggle,
                          ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.apartment.headDescription ??
                              AppLocalizations.of(context)!.noDescription,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.grey[800],
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${widget.apartment.rentFee ?? 'N/A'}\$ / ${AppLocalizations.of(context)!.day}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.apartment.location?['city'] ??
                              AppLocalizations.of(context)!.unknownCity,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey[600]),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        widget.apartment.averageRating?.toStringAsFixed(1) ??
                            'N/A',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
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
