import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/screen/booking_screen.dart';
import 'package:daleel_app_project/screen/editing_apartment.dart';
import 'package:daleel_app_project/widget/apartment_details_widgets/apartment_info_section.dart';
import 'package:daleel_app_project/widget/apartment_details_widgets/comments_section.dart';
import 'package:daleel_app_project/widget/apartment_details_widgets/description_section.dart';
import 'package:daleel_app_project/widget/apartment_details_widgets/images_section.dart';
import 'package:daleel_app_project/widget/apartment_details_widgets/publisher_section.dart';
import 'package:daleel_app_project/widget/apartment_widgets/favorite_widget.dart';
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
    if (!mounted) return;
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
    if (updatedApartment != null) {
      await commentController.fetchComments(
        updatedApartment.id,
        updatedApartment,
      );
    }
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

  Future<void> _onRateButtonPressed() async {
    final rated = await showRatingDialog(context, apartment.id);

    if (rated == true && mounted) {
      await _loadApartmentDetails();
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
        title: Text(
          AppLocalizations.of(context)!.details,
          style: theme.textTheme.titleMedium,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [FavoriteWidget(apartment: apartment)],
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
                      const SizedBox(height: 16),

                      if (userController.user!.userId !=
                              apartment.user.userId &&
                          userController.user!.verificationState == "verified")
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer.withOpacity(
                                0.1,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: OutlinedButton.icon(
                              onPressed: _onRateButtonPressed,
                              icon: Icon(
                                Icons.star_border,
                                color: Colors.amber[700],
                              ),
                              label: Text(
                                AppLocalizations.of(context)!.ratetheDepartment,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: colorScheme.primary,
                                side: BorderSide(
                                  color: colorScheme.primary.withOpacity(0.3),
                                ),
                                shape: const StadiumBorder(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 24),
                      DescriptionSection(apartment: apartment, theme: theme),
                      const SizedBox(height: 30),
                      CommentsSection(
                        comments: List.from(apartment.comments),
                        showAll: showAllComments,
                        controller: _newCommentController,
                        onToggleShow: () =>
                            setState(() => showAllComments = !showAllComments),
                        onSend: () async {
                          final content = _newCommentController.text.trim();
                          if (content.isEmpty) return;

                          try {
                            await commentController.addComment(
                              apartment.id,
                              apartment,
                              content,
                            );
                            setState(() {
                              _newCommentController.clear();
                              showAllComments = true;
                            });
                          } catch (e) {
                            print("Add comment error: $e");
                          }
                        },
                      ),
                      const SizedBox(height: 26),
                      PublisherSection(apartment: apartment, theme: theme),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
          if (apartment.user.userId == userController.user!.userId)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
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
                                EditingApartmentScreen(apartment: apartment),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.editApartment,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimary,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          else if (!apartment.isAvailable!)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                child: Container(
                  color: colorScheme.surface,
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                      ),
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context)!.notAvailableRightNow,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimary,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          else if (userController.user!.verificationState != "verified")
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                child: Container(
                  color: colorScheme.surface,
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                      ),
                      onPressed: () {},
                      child: Text(
                        "you are not verified yet",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimary,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          else
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
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
            ),
        ],
      ),
    );
  }
}
