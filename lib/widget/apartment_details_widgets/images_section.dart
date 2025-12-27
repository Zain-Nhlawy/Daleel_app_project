import 'package:daleel_app_project/dependencies.dart';
import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);

    ImageProvider _getImage(String? img) {
      if (img == null || img.isEmpty) {
        return const AssetImage('assets/images/user.png');
      }

      if (img.startsWith('http')) {
        return NetworkImage(img);
      }

      if (img.startsWith('/')) {
        return NetworkImage('$baseUrl$img');
      }

      return const AssetImage('assets/images/user.png');
    }

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image(
            image: _getImage(selectedImage),
            width: double.infinity,
            height: 260,
            fit: BoxFit.cover,
          ),
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
              final isSelected = img == selectedImage;
              return GestureDetector(
                onTap: () => onImageSelected(img),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected
                        ? Border.all(color: theme.colorScheme.primary, width: 2)
                        : null,
                    image: DecorationImage(
                      image: _getImage(img),
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
