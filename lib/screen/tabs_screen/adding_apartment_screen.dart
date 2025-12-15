// ignore_for_file: unused_element, use_build_context_synchronously
import 'dart:io';
import 'package:daleel_app_project/Cubit/favorites_cubit.dart';
import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/models/comment.dart';
import 'package:daleel_app_project/repository/add_apartments_repo.dart';
import 'package:daleel_app_project/screen/pick_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddingApartmentScreen extends StatefulWidget {
  const AddingApartmentScreen({super.key});

  @override
  State<AddingApartmentScreen> createState() => _AddingApartmentScreenState();
}

class _AddingApartmentScreenState extends State<AddingApartmentScreen> {
  bool _isAvailable = true;
  var _selectedStatusController = 'unfurnished';
  final TextEditingController _locationController = TextEditingController();
  Map<String, dynamic>? selectedLocation;
  File? _selectedImageController;
  final _apartmentHeadDescriptionController = TextEditingController();
  final _apartmentPriceContoller = TextEditingController();
  final _apartmentFloorController = TextEditingController();
  final _apartmentBedroomsController = TextEditingController();
  final _apartmentBathroomsController = TextEditingController();
  final _apartmentAreaController = TextEditingController();
  final _apartmetnDescriptionController = TextEditingController();
  final List<Comment> _apartmentComments = [];
  final List<File> _apartmentPictures = [];

  Future<void> _pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _apartmentPictures.add(File(image.path));
    });
  }

  Future<void> _saveApartment() async {
    if (_apartmentHeadDescriptionController.text.isEmpty ||
        _apartmentPriceContoller.text.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid data', style: TextStyle(color: Colors.red)),
          content: Text('Some of the data are missing or invalid'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    List<File> allImages = [];
    if (_selectedImageController != null) {
      allImages.add(_selectedImageController!);
    }
    allImages.addAll(_apartmentPictures);

    final addRepo = AddApartmentsRepo(dioClient: dioClient);

    try {
      final newApartment = await addRepo.addApartment(
        userId: 4,
        images: allImages,
        location: selectedLocation,
        headDescription: _apartmentHeadDescriptionController.text,
        rentFee: double.tryParse(_apartmentPriceContoller.text) ?? 0,
        floor: int.tryParse(_apartmentFloorController.text) ?? 0,
        bedrooms: int.tryParse(_apartmentBedroomsController.text) ?? 0,
        bathrooms: int.tryParse(_apartmentBathroomsController.text) ?? 0,
        area: double.tryParse(_apartmentAreaController.text),
        description: _apartmetnDescriptionController.text,
        isAvailable: _isAvailable,
        status: _selectedStatusController,
      );

      setState(() {
        apartments.add(newApartment);
      });
      _apartmentHeadDescriptionController.clear();
      _apartmentPriceContoller.clear();
      _apartmentFloorController.clear();
      _apartmentBedroomsController.clear();
      _apartmentBathroomsController.clear();
      _apartmentAreaController.clear();
      _apartmetnDescriptionController.clear();
      _selectedImageController = null;
      _apartmentPictures.clear();
      _apartmentComments.clear();

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Success'),
          content: Text('Your apartment was added successfully!'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Okay'),
            ),
          ],
        ),
      );
    } catch (e) {
      print("Error adding apartment: $e");
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error', style: TextStyle(color: Colors.red)),
          content: Text('Failed to add apartment. Please try again.'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _pickLocation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PickLocationScreen()),
    );

    if (result != null && result is Map) {
      setState(() {
        selectedLocation = Map<String, dynamic>.from(result);

        _locationController.text =
            "${result['governorate']}, ${result['city']}, ${result['district']}, ${result['street']}";
      });
    }
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
            const SizedBox(height: 15),
            Row(
              children: [
                const SizedBox(width: 15),
                Text(
                  'Select the Head Image',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 20),
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
                            child: _selectedImageController != null
                                ? Stack(
                                    children: [
                                      Center(
                                        child: Image.file(
                                          _selectedImageController!,
                                        ),
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
                                      const SizedBox(width: 10),
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
            const SizedBox(height: 15),
            Row(
              children: [
                const SizedBox(width: 15),
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
                        controller: _apartmentHeadDescriptionController,
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
                const SizedBox(width: 40),
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
                          controller: _apartmentPriceContoller,
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
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text('Status', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(174, 248, 245, 245),
                      ),
                      height: 48,
                      child: DropdownButton(
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        elevation: 8,
                        value: _selectedStatusController,
                        items:
                            ['partially furnished', 'unfurnished', 'furnished']
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(
                                      category.toUpperCase(),
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
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
                            _selectedStatusController = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(height: 15),
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
                      Icon(Icons.bed, color: Colors.blueGrey, size: 32),
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
                                    controller: _apartmentBedroomsController,
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
                      Icon(Icons.shower, color: Colors.blueGrey, size: 32),
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
                                    controller: _apartmentBathroomsController,
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
                      Icon(Icons.apartment, color: Colors.blueGrey, size: 32),
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
                                    controller: _apartmentFloorController,
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
                      Icon(Icons.square_foot, color: Colors.blueGrey, size: 32),
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
                                    controller: _apartmentAreaController,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.event_available_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    'Available for Rent Now',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  trailing: Switch(
                    value: _isAvailable,
                    onChanged: (newValue) {
                      setState(() {
                        _isAvailable = newValue;
                      });
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () {
                    setState(() {
                      _isAvailable = !_isAvailable;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: _pickLocation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Theme.of(context).colorScheme.primary,
                          size: 24,
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            _locationController.text.isEmpty
                                ? 'Select Apartment Location'
                                : _locationController.text,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: _locationController.text.isEmpty
                                      ? Colors.grey.shade600
                                      : Theme.of(
                                          context,
                                        ).colorScheme.onBackground,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Apartment Pictures',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _apartmentPictures.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return GestureDetector(
                        onTap: () async {
                          final image = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                          );

                          if (image == null) return;

                          setState(() {
                            _apartmentPictures.add(File(image.path));
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.brown.withOpacity(0.15),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 40,
                            color: Colors.brown,
                          ),
                        ),
                      );
                    }
                    final picturePath = _apartmentPictures[index - 1];

                    return Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 12),
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: FileImage(picturePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _apartmentPictures.removeAt(index - 1);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const SizedBox(width: 15),
                Text(
                  'Side Description',
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
                height: 150,
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        maxLength: 120,
                        maxLines: 3,
                        controller: _apartmetnDescriptionController,
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
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown,
            minimumSize: Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: _saveApartment,
          child: Text(
            "Add Apartment",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
