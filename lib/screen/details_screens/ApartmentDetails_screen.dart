import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/screen/booking_screen.dart';
import 'package:daleel_app_project/services/apartment_service.dart';
import 'package:daleel_app_project/widget/apartment_details_widgets/apartment_info_section.dart';
import 'package:daleel_app_project/widget/apartment_details_widgets/comments_section.dart';
import 'package:daleel_app_project/widget/apartment_details_widgets/description_section.dart';
import 'package:daleel_app_project/widget/apartment_details_widgets/images_section.dart';
import 'package:daleel_app_project/widget/apartment_details_widgets/publisher_section.dart';
import 'package:daleel_app_project/widget/rate_dialog.dart';
import 'package:flutter/material.dart';

class ApartmentDetailsScreen extends StatefulWidget {
  final Apartments2 apartment;
  final bool withRate;
  const ApartmentDetailsScreen({
    super.key,
    this.withRate = false,
    required this.apartment,
  });

  @override
  State<ApartmentDetailsScreen> createState() => _ApartmentDetailsScreenState();
}

class _ApartmentDetailsScreenState extends State<ApartmentDetailsScreen> {
  late Apartments2 apartment;
  late bool withRate;
  bool isLoading = true;
  late String selectedImage;
  bool showAllComments = false;
  late TextEditingController _newCommentController;
  late bool? _isFavorited = widget.apartment.isFavorited;
  final bool _isFavoriteLoading = false;

  @override
  void initState() {
    super.initState();
    apartment = widget.apartment;
    withRate = widget.withRate;
    selectedImage = apartment.images.isNotEmpty
        ? apartment.images.first
        : 'assets/images/user.png';
    _newCommentController = TextEditingController();
    _loadData();
  }

  void _loadData() async {
    await _loadApartmentDetails();
    await commentController.fetchComments(apartment.id);
    if (withRate && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final rated = await showRatingDialog(context, apartment.id);
        if (rated == true && mounted) {
          await _loadApartmentDetails();
        }
      });
    }
  }

  Future<void> _loadApartmentDetails() async {
    final updatedApartment = await apartmentController.fetchApartment(
      apartment.id,
    );
    if (!mounted) return;

    setState(() {
      if (updatedApartment != null) {
        apartment = updatedApartment;
        selectedImage = apartment.images.isNotEmpty
            ? apartment.images.first
            : 'assets/images/user.png';
      }
      isLoading = false;
    });
  }

  void _handleFavoriteToggle() async {
    setState(() {
      _isFavorited = !_isFavorited!;
    });

    final apartmentService = ApartmentService(apiClient: dioClient);
    try {
      final bool success = await apartmentService.toggleFavorite(apartment.id);
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
  void dispose() {
    _newCommentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.details,
          style: theme.textTheme.titleMedium,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          _isFavoriteLoading
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                )
              : IconButton(
                  icon: Icon(
                    _isFavorited! ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorited!
                        ? colorScheme.error
                        : colorScheme.onSurface,
                    size: 28,
                  ),
                  onPressed: _handleFavoriteToggle,
                ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImagesSection(
                  selectedImage: selectedImage,
                  images: apartment.images.isNotEmpty
                      ? apartment.images
                      : ['assets/images/user.png'],
                  onImageSelected: (img) {
                    setState(() => selectedImage = img);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ApartmentInfoSection(apartment: apartment, theme: theme),
                      const SizedBox(height: 24),
                      DescriptionSection(apartment: apartment, theme: theme),
                      const SizedBox(height: 30),
                      CommentsSection(
                        comments: commentController.comments,
                        showAll: showAllComments,
                        theme: theme,
                        controller: _newCommentController,
                        onToggleShow: () =>
                            setState(() => showAllComments = !showAllComments),
                        onSend: () async {
                          final content = _newCommentController.text.trim();
                          if (content.isEmpty) return;
                          setState(() {
                            _newCommentController.clear();
                            showAllComments = true;
                          });
                          try {
                            await commentController.addComment(
                              apartment.id,
                              content,
                            );
                          } catch (e) {}
                          await commentController.fetchComments(apartment.id);
                          if (!mounted) return;
                          setState(() {
                            apartment.comments = commentController.comments;
                          });
                        },
                      ),
                      const SizedBox(height: 26),
                      PublisherSection(apartment: apartment, theme: theme),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: colorScheme.surface,
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BookingCalendar(apartment: apartment),
                      ),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.bookNow,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimary,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
