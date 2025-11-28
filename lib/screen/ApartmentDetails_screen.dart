import 'package:daleel_app_project/widget/custom_text_field.dart';
import 'package:daleel_app_project/widget/custom_button.dart';
import 'package:flutter/material.dart';
import '../models/apartments.dart';

class ApartmentDetailsScreen extends StatefulWidget {
  final Apartments apartment;

  const ApartmentDetailsScreen({super.key, required this.apartment});

  @override
  State<ApartmentDetailsScreen> createState() => _ApartmentDetailsScreenState();
}

class _ApartmentDetailsScreenState extends State<ApartmentDetailsScreen> {
  late String selectedImage;
  bool showAllComments = false;
  late TextEditingController _newCommentController;

  @override
  void initState() {
    super.initState();
    selectedImage = widget.apartment.apartmentPictures.first;
    _newCommentController = TextEditingController();
  }

  @override
  void dispose() {
    _newCommentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final comments = widget.apartment.comments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Details', style: theme.textTheme.titleMedium),
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
                  images: widget.apartment.apartmentPictures.isNotEmpty
                      ? widget.apartment.apartmentPictures
                      : [widget.apartment.apartmentPicture],
                  onImageSelected: (img) {
                    setState(() => selectedImage = img);
                  },
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      ApartmentInfoSection(apartment: widget.apartment, theme: theme),

                      const SizedBox(height: 24),


                      DescriptionSection(apartment: widget.apartment, theme: theme),

                      const SizedBox(height: 30),


                      CommentsSection(
                        comments: comments,
                        showAll: showAllComments,
                        theme: theme,
                        controller: _newCommentController,
                        onToggleShow: () => setState(() => showAllComments = !showAllComments),
                        onSend: () {
                          if (_newCommentController.text.isNotEmpty) {
                            setState(() {
                              comments.add(_newCommentController.text);
                              _newCommentController.clear();
                              showAllComments = true;
                            });
                          }
                        },
                      ),

                      const SizedBox(height: 26),


                      PublisherSection(
                        apartment: widget.apartment,
                        theme: theme,
                      ),

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
                  onPressed: () {},
                  child: Text(
                    "Book Now",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white, fontSize: 18),
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


class ImagesSection extends StatelessWidget {
  final String selectedImage;
  final List<String> images;
  final ValueChanged<String> onImageSelected;

  const ImagesSection({
    super.key,
    required this.selectedImage,
    required this.images,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          selectedImage,
          width: double.infinity,
          height: 260,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 10),

        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: images.length,
            itemBuilder: (context, index) {
              final img = images[index];
              return GestureDetector(
                onTap: () => onImageSelected(img),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      )
                    ],
                    image: DecorationImage(
                      image: AssetImage(img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}


class ApartmentInfoSection extends StatelessWidget {
  final Apartments apartment;
  final ThemeData theme;

  const ApartmentInfoSection({
    super.key,
    required this.apartment,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          apartment.apartmentHeadDescripton,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.red, size: 22),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                apartment.apartmentCountry,
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
              ),
            ),
            const Icon(Icons.star_rounded, color: Colors.amber, size: 24),
            const SizedBox(width: 4),
            Text(apartment.apartmentRate.toStringAsFixed(1)),
          ],
        ),
        const SizedBox(height: 6),

        Row(
          children: [
            const Icon(Icons.attach_money, color: Colors.green, size: 22),
            Text("${apartment.price} / month",
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[700])),
          ],
        ),
        const SizedBox(height: 22),

        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3.2,
          ),
          children: [
            _infoTile(Icons.bed, "Bedroom", "${apartment.bedrooms}", theme),
            _infoTile(Icons.shower, "Bathroom", "${apartment.bathrooms}", theme),
            _infoTile(Icons.apartment, "Floor", "${apartment.floor}", theme),
            _infoTile(Icons.square_foot, "Area", "${apartment.area} m²", theme),
          ],
        ),
      ],
    );
  }

  Widget _infoTile(IconData icon, String title, String value, ThemeData theme) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueGrey, size: 32),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.bodyMedium),
            Text(value,
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}


class DescriptionSection extends StatelessWidget {
  final Apartments apartment;
  final ThemeData theme;

  const DescriptionSection({
    super.key,
    required this.apartment,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Description",
            style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(
          apartment.description,
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
        ),
      ],
    );
  }
}


class CommentsSection extends StatelessWidget {
  final List<String> comments;
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
        Text("Comments",
            style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),

        Column(
          children: [
            for (int i = 0;
                i < (showAll ? comments.length : comments.length.clamp(0, 3));
                i++)
              Column(
                children: [
                  _commentRow(
                    name: "User ${i + 1}",
                    image: "assets/images/profilePic.png",
                    comment: comments[i],
                    theme: theme,
                  ),
                  if (i < comments.length - 1)
                    Divider(color: Colors.grey.shade300),
                ],
              ),

            if (comments.length > 3)
              TextButton(
                onPressed: onToggleShow,
                child: Text(
                  showAll ? "Show Less" : "Show More",
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
              ),
          ],
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: CustomTextField(
                  controller: controller,
                  label: "",
                  hint: "Add a comment...",
                  icon: Icons.comment,
                  readOnly: false,
                  borderColor: Colors.brown.shade400,
                ),
              ),
            ),
            const SizedBox(width: 8),

            CustomButton(
              text: "Send",
              bordered: true,
              color: theme.colorScheme.primary,
              textColor: theme.colorScheme.primary,
              onPressed: onSend,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ],
        ),
      ],
    );
  }

  Widget _commentRow({
    required String name,
    required String image,
    required String comment,
    required ThemeData theme,
  }) {
    return Row(
      children: [
        CircleAvatar(radius: 22, backgroundImage: AssetImage(image)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style:
                      theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(comment, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}


class PublisherSection extends StatelessWidget {
  final Apartments apartment;
  final ThemeData theme;

  const PublisherSection({
    super.key,
    required this.apartment,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Published By",
            style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),

        Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage("assets/images/profilePic.png"),
            ),
            const SizedBox(width: 12),

            Text(
              apartment.publisherName,
              style:
                  theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),

            const Spacer(),

            CustomButton(
              text: "Contact Us",
              bordered: true,
              color: theme.colorScheme.primary,
              textColor: theme.colorScheme.primary,
              icon: Icons.chat_bubble_outline,
              onPressed: () {},
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ],
        ),
      ],
    );
  }
}
