import 'dart:io';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddingApartmentScreen extends StatefulWidget {
  const AddingApartmentScreen({super.key});

  @override
  State<AddingApartmentScreen> createState() => _AddingApartmentScreenState();
}

class _AddingApartmentScreenState extends State<AddingApartmentScreen> {
  File? _selectedImage;
  ApartmentCountry? _selectedCountry;

  Future _pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _selectedImage = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Apartment',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 15),
                Text(
                  'Select the Head Image',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  _pickImageFromGallery();
                },
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: _selectedImage != null
                                ? Stack(
                                    children: [
                                      Center(
                                        child: Image.file(_selectedImage!),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_a_photo_outlined,
                                        size: 50,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 15),
                Text(
                  'Head Description',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(174, 248, 245, 245),
                ),
                height: 48,
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 28,
                      color: Color.fromARGB(141, 121, 85, 72),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        maxLength: 20,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Villa , Doplox ....',
                          hintStyle: TextStyle(
                            color: Colors.brown.withAlpha((0.5 * 255).toInt()),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 15),

                Text('Price', style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(width: 40),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(174, 248, 245, 245),
                  ),
                  height: 48,
                  width: 150,
                  child: Row(
                    children: [
                      const SizedBox(width: 12),

                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            suffixText: '\$ /Month ',
                            border: InputBorder.none,

                            hintText: '0.0',
                            hintStyle: TextStyle(
                              color: Colors.brown.withAlpha(
                                (0.5 * 255).toInt(),
                              ),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),

            Row(
              children: [
                SizedBox(width: 15),
                Text('Countrey'),
                SizedBox(width: 20),
                DropdownButton(
                  elevation: 8,
                  value: _selectedCountry,
                  items: ApartmentCountry.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCountry = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16),
              child: GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                ),
                children: [
                  Row(
                    children: [
                      Icon(Icons.bed, color: Colors.brown, size: 32),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bedrooms',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromARGB(174, 248, 245, 245),
                            ),
                            height: 48,
                            width: 100,
                            child: Row(
                              children: [
                                const SizedBox(width: 12),

                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '0',
                                      hintStyle: TextStyle(
                                        color: Colors.brown.withAlpha(
                                          (0.5 * 255).toInt(),
                                        ),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.shower, color: Colors.brown, size: 32),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bathrooms',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromARGB(174, 248, 245, 245),
                            ),
                            height: 48,
                            width: 100,
                            child: Row(
                              children: [
                                const SizedBox(width: 12),

                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '0',
                                      hintStyle: TextStyle(
                                        color: Colors.brown.withAlpha(
                                          (0.5 * 255).toInt(),
                                        ),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.apartment, color: Colors.brown, size: 32),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Floor',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromARGB(174, 248, 245, 245),
                            ),
                            height: 48,
                            width: 100,
                            child: Row(
                              children: [
                                const SizedBox(width: 12),

                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '0',
                                      hintStyle: TextStyle(
                                        color: Colors.brown.withAlpha(
                                          (0.5 * 255).toInt(),
                                        ),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.square_foot, color: Colors.brown, size: 32),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Area',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromARGB(174, 248, 245, 245),
                            ),
                            height: 48,
                            width: 100,
                            child: Row(
                              children: [
                                const SizedBox(width: 12),

                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '0',
                                      hintStyle: TextStyle(
                                        color: Colors.brown.withAlpha(
                                          (0.5 * 255).toInt(),
                                        ),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
