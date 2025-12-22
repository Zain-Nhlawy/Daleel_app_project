// ignore_for_file: unused_element, use_build_context_synchronously, deprecated_member_use

import 'dart:io';
import 'package:daleel_app_project/screen/confirm_add_screen.dart';
import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/user.dart';
import 'package:daleel_app_project/repository/add_apartments_repo.dart';
import 'package:daleel_app_project/screen/pick_location_screen.dart';
import 'package:daleel_app_project/screen/tabs_screen/home_screen_tabs.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddingApartmentScreen extends StatefulWidget {
  const AddingApartmentScreen({super.key});

  @override
  State<AddingApartmentScreen> createState() => _AddingApartmentScreenState();
}

class _AddingApartmentScreenState extends State<AddingApartmentScreen> {
  final User? user = userController.user;
  final _formKey = GlobalKey<FormState>();
  bool _isAvailable = true;
  String _selectedStatusController = 'unfurnished';
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
  final List<File> _apartmentPictures = [];

  Future<void> _pickImage(
    ImageSource source, {
    bool isHeadImage = false,
  }) async {
    final image = await ImagePicker().pickImage(
      source: source,
      imageQuality: 80,
    );
    if (image == null) return;
    final imageFile = File(image.path);
    setState(() {
      if (isHeadImage) {
        _selectedImageController = imageFile;
      } else {
        _apartmentPictures.add(imageFile);
      }
    });
  }

  void _triggerSaveProcess() {
    if (!_formKey.currentState!.validate() ||
        _selectedImageController == null ||
        selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(
              context,
            )!.pleaseFillAllRequiredFieldsSelectALocationAndAddAHeadImage,
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showConfirmationSheet(
      context: context,
      onConfirm: (File contractImage) {
        _saveApartment(contractImage);
      },
    );
  }

  Future<void> _saveApartment(File contractImage) async {
    final addRepo = AddApartmentsRepo(dioClient: dioClient);
    try {
      await addRepo.addApartment(
        userId: user!.userId,
        images: [_selectedImageController!, ..._apartmentPictures],
        // contractImage: contractImage,
        location: selectedLocation,
        state: false,
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
      _showPendingApprovalDialog();
    } catch (e) {
      _showErrorDialog(
        AppLocalizations.of(context)!.failedToAddApartmentPleaseTryAgain,
      );
    }
  }

  void _showPendingApprovalDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Center(
          child: Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 50,
          ),
        ),
        content: Text(
          AppLocalizations.of(
            context,
          )!.requestSubmittedYourApartmentIsNowPendingAdminApproval,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                ctx,
                MaterialPageRoute(builder: (context) => const HomeScreenTabs()),
                (Route<dynamic> route) => false,
              );
            },
            child: Text(
              AppLocalizations.of(context)!.okay,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.error,
          style: TextStyle(color: Colors.red),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppLocalizations.of(context)!.okay),
          ),
        ],
      ),
    );
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
            "${result['governorate']}, ${result['city']}, ${result['district']}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF795548);
    final textStyle = const TextStyle(color: Colors.white);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context)!.addApartment,
          style: textStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 219, 155, 132),
              Color.fromARGB(255, 255, 255, 255),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ).copyWith(top: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader(
                  AppLocalizations.of(context)!.mainImage,
                  textStyle,
                ),
                _buildHeadImagePicker(primaryColor),
                const SizedBox(height: 24),
                _buildSectionHeader(
                  AppLocalizations.of(context)!.details,
                  textStyle,
                ),
                _buildTextField(
                  _apartmentHeadDescriptionController,
                  AppLocalizations.of(context)!.titleegModernVilla,
                  Icons.title,
                ),
                _buildTextField(
                  _apartmentPriceContoller,
                  '${AppLocalizations.of(context)!.price} / ${AppLocalizations.of(context)!.day}',
                  Icons.monetization_on,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                _buildStatusDropdown(primaryColor),
                const SizedBox(height: 10),
                _buildSectionHeader(
                  AppLocalizations.of(context)!.features,
                  textStyle,
                ),
                _buildFeaturesGrid(),
                const SizedBox(height: 10),
                _buildSectionHeader(
                  AppLocalizations.of(context)!.location,
                  textStyle,
                ),
                _buildLocationPicker(primaryColor),
                const SizedBox(height: 16),
                _buildAvailabilitySwitch(primaryColor),
                const SizedBox(height: 24),
                _buildSectionHeader(
                  AppLocalizations.of(context)!.morePictures,
                  textStyle,
                ),
                _buildImageGallery(primaryColor),
                const SizedBox(height: 24),
                _buildSectionHeader(
                  AppLocalizations.of(context)!.description,
                  textStyle,
                ),
                _buildTextField(
                  _apartmetnDescriptionController,
                  AppLocalizations.of(context)!.tellUsMoreAboutYourPlace,
                  Icons.description,
                  maxLines: 4,
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildSaveButton(primaryColor),
    );
  }

  Widget _buildSaveButton(Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: _triggerSaveProcess,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: primaryColor,
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        child: Text(AppLocalizations.of(context)!.addApartment),
      ),
    );
  }

  Widget _buildSectionHeader(String title, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0, top: 4.0),
      child: Text(
        title,
        style: style.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHeadImagePicker(Color primaryColor) {
    return GestureDetector(
      onTap: () => _pickImage(ImageSource.gallery, isHeadImage: true),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
          image: _selectedImageController != null
              ? DecorationImage(
                  image: FileImage(_selectedImageController!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: _selectedImageController == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.white,
                      size: 50,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.tapToAddMainImage,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )
            : Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () =>
                      setState(() => _selectedImageController = null),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    int? maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white, fontSize: 15),
          prefixIcon: Icon(icon, color: Colors.white),
          filled: true,
          fillColor: Colors.black.withOpacity(0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.thisFieldCannotBeEmpty;
          }
          return null;
        },
      ),
    );
  }

  Widget _buildStatusDropdown(Color primaryColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedStatusController,
          isExpanded: true,
          dropdownColor: primaryColor,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          style: const TextStyle(color: Colors.white, fontSize: 16),
          items: ['partially furnished', 'unfurnished', 'furnished']
              .map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(category.toUpperCase()),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => _selectedStatusController = value);
            }
          },
        ),
      ),
    );
  }

  Widget _buildFeaturesGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        _buildFeatureField(
          _apartmentBedroomsController,
          AppLocalizations.of(context)!.bedrooms,
          Icons.bed_outlined,
        ),
        _buildFeatureField(
          _apartmentBathroomsController,
          AppLocalizations.of(context)!.bathrooms,
          Icons.shower_outlined,
        ),
        _buildFeatureField(
          _apartmentFloorController,
          AppLocalizations.of(context)!.floor,
          Icons.layers_outlined,
        ),
        _buildFeatureField(
          _apartmentAreaController,
          AppLocalizations.of(context)!.areaM2,
          Icons.square_foot_outlined,
        ),
      ],
    );
  }

  Widget _buildFeatureField(
    TextEditingController controller,
    String label,
    IconData icon,
  ) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
        prefixIcon: Icon(icon, color: Colors.white, size: 20),
        filled: true,
        fillColor: Colors.black.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        if (double.tryParse(value) == null) {
          return 'Invalid';
        }
        return null;
      },
    );
  }

  Widget _buildLocationPicker(Color primaryColor) {
    return GestureDetector(
      onTap: _pickLocation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            const Icon(Icons.location_on_outlined, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _locationController.text.isEmpty
                    ? AppLocalizations.of(context)!.selectApartmentLocation
                    : _locationController.text,
                style: const TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilitySwitch(Color primaryColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.availableForRent,
            style: TextStyle(color: Colors.white),
          ),
          Switch(
            value: _isAvailable,
            onChanged: (value) => setState(() => _isAvailable = value),
            activeTrackColor: primaryColor,
            activeColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildImageGallery(Color primaryColor) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _apartmentPictures.length + 1,
        itemBuilder: (context, index) {
          if (index == _apartmentPictures.length) {
            return _buildAddImageButton();
          }
          return _buildImageThumbnail(_apartmentPictures[index], index);
        },
      ),
    );
  }

  Widget _buildAddImageButton() {
    return GestureDetector(
      onTap: () => _pickImage(ImageSource.gallery),
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Icon(
          Icons.add_photo_alternate_outlined,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildImageThumbnail(File image, int index) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 8),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.file(image, fit: BoxFit.cover),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () => setState(() => _apartmentPictures.removeAt(index)),
              child: const Icon(Icons.cancel, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}
