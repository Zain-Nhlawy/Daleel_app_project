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
import 'package:flutter/material.dart';

class ApartmentDetailsScreen extends StatefulWidget {
  final Apartments2 apartment;
  const ApartmentDetailsScreen({super.key, required this.apartment});

  @override
  State<ApartmentDetailsScreen> createState() => _ApartmentDetailsScreenState();
}

class _ApartmentDetailsScreenState extends State<ApartmentDetailsScreen> {
  late Apartments2 apartment;
  bool isLoading = true;
  late String selectedImage;
  bool showAllComments = false;
  late TextEditingController _newCommentController;
  bool _isFavorited = false;
  bool _isFavoriteLoading = true;

  @override
  void initState() {
    super.initState();
    apartment = widget.apartment;
    selectedImage = apartment.images.isNotEmpty
        ? apartment.images.first
        : 'assets/images/user.png';
    _newCommentController = TextEditingController();
    _loadData();
  }

  void _loadData() async {
    await _loadApartmentDetails();
    await _fetchInitialFavoriteStatus();
    await commentController.fetchComments(apartment.id);
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

  Future<void> _fetchInitialFavoriteStatus() async {
    final apartmentService = ApartmentService(apiClient: dioClient);
    try {
      final bool? result = await apartmentService.isFavourite(apartment.id);
      if (mounted) {
        setState(() {
          _isFavorited = result ?? false;
          _isFavoriteLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isFavoriteLoading = false;
        });
      }
    }
  }

  void _handleFavoriteToggle() async {
    setState(() {
      _isFavorited = !_isFavorited;
    });

    final apartmentService = ApartmentService(apiClient: dioClient);
    try {
      final bool success = await apartmentService.toggleFavorite(apartment.id);
      if (!success && mounted) {
        setState(() {
          _isFavorited = !_isFavorited;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isFavorited = !_isFavorited;
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.details,
          style: theme.textTheme.titleMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          _isFavoriteLoading
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.black54,
                    ),
                  ),
                )
              : IconButton(
                  icon: Icon(
                    _isFavorited ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorited ? Colors.red : Colors.black54,
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
              color: Colors.white,
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
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
                      color: Colors.white,
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
