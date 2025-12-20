import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/screen/booking_screen.dart';
import 'package:daleel_app_project/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:daleel_app_project/widget/apartment_details_widgets/images_section.dart';
import 'package:daleel_app_project/widget/apartment_details_widgets/apartment_info_section.dart';
import 'package:daleel_app_project/widget/apartment_details_widgets/description_section.dart';
import 'package:daleel_app_project/widget/apartment_details_widgets/comments_section.dart';
import 'package:daleel_app_project/widget/apartment_details_widgets/publisher_section.dart';

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

  @override
  void initState() {
    super.initState();
    apartment = widget.apartment;
    selectedImage = apartment.images.isNotEmpty
        ? apartment.images.first
        : 'assets/images/user.png';
    _newCommentController = TextEditingController();
    _loadApartmentDetails();
    commentController.fetchComments(apartment.id);
  }

  void _loadApartmentDetails() async {
    final updatedApartment = await apartmentController.fetchApartment(
      apartment.id,
    );
    if (!mounted) return;
    if (updatedApartment != null) {
      setState(() {
        apartment = updatedApartment;
        selectedImage = apartment.images.isNotEmpty
            ? apartment.images.first
            : 'assets/images/user.png';
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
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
        title: Text(AppLocalizations.of(context)!.details, style: theme.textTheme.titleMedium),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
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
                          } catch (e) {
                            print("Failed to add comment: $e");
                          }
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
