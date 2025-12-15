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
    ImageProvider _getImage(String img) {
      if (img.startsWith('http')) return NetworkImage(img);
      return AssetImage(img);
    }

    return Column(
      children: [
        Image(
          image: _getImage(selectedImage),
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
