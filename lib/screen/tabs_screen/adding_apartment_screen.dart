import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddingApartmentScreen extends StatefulWidget {
  const AddingApartmentScreen({super.key});

  @override
  State<AddingApartmentScreen> createState() => _AddingApartmentScreenState();
}

class _AddingApartmentScreenState extends State<AddingApartmentScreen> {
  File? _selectedImage;

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

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('head pic'),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: _selectedImage != null
                              ? Stack(
                                  children: [
                                    Center(child: Image.file(_selectedImage!)),
                                  ],
                                )
                              : Center(child: Text('PLease select an image')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
