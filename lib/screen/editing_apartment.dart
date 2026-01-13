// ignore_for_file: unused_element, use_build_context_synchronously, deprecated_member_use

import 'dart:io';

import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/models/user.dart';
import 'package:daleel_app_project/repository/add_apartments_repo.dart';
import 'package:daleel_app_project/screen/pick_location_screen.dart';
import 'package:daleel_app_project/screen/tabs_screen/home_screen_tabs.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditingApartmentScreen extends StatefulWidget {
  const EditingApartmentScreen({required this.apartment, super.key});

  final Apartments2 apartment;

  @override
  State<EditingApartmentScreen> createState() => _EditingApartmentScreenState();
}

class _EditingApartmentScreenState extends State<EditingApartmentScreen> {
  final User? user = userController.user;
  final _formKey = GlobalKey<FormState>();

  late bool _isAvailable = widget.apartment.isAvailable!;
  late String _selectedStatusController = widget.apartment.status!;
  late final TextEditingController _locationController = TextEditingController(
    text: widget.apartment.location.toString(),
  );
  late Map<String, dynamic>? selectedLocation = widget.apartment.location;

  dynamic _headImage;

  final List<dynamic> _additionalImages = [];

  late final _apartmentHeadDescriptionController = TextEditingController(
    text: widget.apartment.headDescription,
  );
  late final _apartmentPriceContoller = TextEditingController(
    text: widget.apartment.rentFee.toString(),
  );
  late final _apartmentFloorController = TextEditingController(
    text: widget.apartment.floor.toString(),
  );
  late final _apartmentBedroomsController = TextEditingController(
    text: widget.apartment.bedrooms.toString(),
  );
  late final _apartmentBathroomsController = TextEditingController(
    text: widget.apartment.bathrooms.toString(),
  );
  late final _apartmentAreaController = TextEditingController(
    text: widget.apartment.area.toString(),
  );
  late final _apartmetnDescriptionController = TextEditingController(
    text: widget.apartment.description,
  );

  @override
  void initState() {
    super.initState();

    if (widget.apartment.images.isNotEmpty) {
      _headImage = widget.apartment.images[0];
      if (widget.apartment.images.length > 1) {
        _additionalImages.addAll(widget.apartment.images.sublist(1));
      }
    }
  }

  Future<void> _pickImage(
    ImageSource source, {
    bool isHeadImage = false,
  }) async {
    final image = await ImagePicker().pickImage(
      source: source,
      imageQuality: 80,
    );
    if (image == null) return;

    setState(() {
      final file = File(image.path);
      if (isHeadImage) {
        _headImage = file;
      } else {
        _additionalImages.add(file);
      }
    });
  }

  void _triggerSaveProcess() {
    if (!_formKey.currentState!.validate() ||
        _headImage == null ||
        selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(
              context,
            )!.pleaseFillAllRequiredFieldsSelectALocationAndAddAHeadImage,
          ),
        ),
      );
      return;
    }
    _saveApartment();
  }

  Future<void> _saveApartment() async {
    final addRepo = AddApartmentsRepo(dioClient: dioClient);

    List<File> imagesToSend = [];
    List<String> imageUrlsToKeep = [];

    if (_headImage is File) {
      imagesToSend.add(_headImage as File);
    } else if (_headImage is String) {
      imageUrlsToKeep.add(_headImage as String);
    }

    for (var img in _additionalImages) {
      if (img is File) {
        imagesToSend.add(img);
      } else if (img is String) {
        imageUrlsToKeep.add(img);
      }
    }

    try {
      await addRepo.editApartment(
        id: widget.apartment.id,
        userId: user!.userId,
        images: imagesToSend,
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
    } catch (_) {
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
        title: const Icon(Icons.check_circle_outline, size: 48),
        content: Text(
          AppLocalizations.of(
            context,
          )!.requestSubmittedYourApartmentIsNowPendingAdminApproval,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                ctx,
                MaterialPageRoute(builder: (_) => const HomeScreenTabs()),
                (_) => false,
              );
            },
            child: Text(AppLocalizations.of(context)!.okay),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.error),
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
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.editApartment,
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.background,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 110, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader(AppLocalizations.of(context)!.mainImage),
                _headImagePicker(),
                _sectionHeader(AppLocalizations.of(context)!.details),
                _textField(
                  _apartmentHeadDescriptionController,
                  AppLocalizations.of(context)!.titleegModernVilla,
                  Icons.title,
                ),
                _textField(
                  _apartmentPriceContoller,
                  '${AppLocalizations.of(context)!.price} / ${AppLocalizations.of(context)!.day}',
                  Icons.monetization_on,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                _statusDropdown(),
                _sectionHeader(AppLocalizations.of(context)!.features),
                _featuresGrid(),
                _sectionHeader(AppLocalizations.of(context)!.location),
                _locationPicker(),
                const SizedBox(height: 12),
                _availabilitySwitch(),
                _sectionHeader(AppLocalizations.of(context)!.morePictures),
                _imageGallery(),
                _sectionHeader(AppLocalizations.of(context)!.description),
                _textField(
                  _apartmetnDescriptionController,
                  AppLocalizations.of(context)!.tellUsMoreAboutYourPlace,
                  Icons.description,
                  maxLines: 4,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _triggerSaveProcess,
          style: ElevatedButton.styleFrom(
            backgroundColor: scheme.primary,
            foregroundColor: scheme.onPrimary,
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(AppLocalizations.of(context)!.editApartment),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 8),
      child: Text(
        title,
        style: TextStyle(
          color: scheme.onBackground,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _textField(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: scheme.primary),
          filled: true,
          fillColor: scheme.surface.withOpacity(0.9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (v) => v == null || v.isEmpty
            ? AppLocalizations.of(context)!.thisFieldCannotBeEmpty
            : null,
      ),
    );
  }

  Widget _statusDropdown() {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: scheme.surface.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedStatusController,
          isExpanded: true,
          items: [
            AppLocalizations.of(context)!.partiallyFurnished,
            AppLocalizations.of(context)!.unfurnished,
            AppLocalizations.of(context)!.furnished,
          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) => setState(() => _selectedStatusController = v!),
        ),
      ),
    );
  }

  Widget _featuresGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.8,
      children: [
        _featureField(
          _apartmentBedroomsController,
          AppLocalizations.of(context)!.bedrooms,
          Icons.bed,
        ),
        _featureField(
          _apartmentBathroomsController,
          AppLocalizations.of(context)!.bathrooms,
          Icons.shower,
        ),
        _featureField(
          _apartmentFloorController,
          AppLocalizations.of(context)!.floor,
          Icons.layers,
        ),
        _featureField(
          _apartmentAreaController,
          AppLocalizations.of(context)!.areaM2,
          Icons.square_foot,
        ),
      ],
    );
  }

  Widget _featureField(
    TextEditingController controller,
    String label,
    IconData icon,
  ) {
    return _textField(
      controller,
      label,
      icon,
      keyboardType: TextInputType.number,
    );
  }

  Widget _locationPicker() {
    return GestureDetector(
      onTap: _pickLocation,
      child: _surfaceTile(
        icon: Icons.location_on_outlined,
        text: _locationController.text.isEmpty
            ? AppLocalizations.of(context)!.selectApartmentLocation
            : _locationController.text,
      ),
    );
  }

  Widget _availabilitySwitch() {
    return _surfaceTile(
      child: Switch(
        value: _isAvailable,
        onChanged: (v) => setState(() => _isAvailable = v),
        activeTrackColor: Theme.of(context).colorScheme.primary,
      ),
      text: AppLocalizations.of(context)!.availableForRent,
    );
  }

  Widget _headImagePicker() {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => _pickImage(ImageSource.gallery, isHeadImage: true),
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: scheme.surface.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          image: _headImage != null
              ? DecorationImage(
                  image: _headImage is File
                      ? FileImage(_headImage as File)
                      : NetworkImage(_headImage as String) as ImageProvider,
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: _headImage == null
            ? Center(
                child: Icon(
                  Icons.add_a_photo_outlined,
                  size: 48,
                  color: scheme.primary.withOpacity(0.6),
                ),
              )
            : null,
      ),
    );
  }

  Widget _imageGallery() {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _additionalImages.length + 1,
        itemBuilder: (context, index) {
          if (index == _additionalImages.length) {
            return GestureDetector(
              onTap: () => _pickImage(ImageSource.gallery),
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: scheme.surface.withOpacity(0.5),
                  border: Border.all(color: scheme.primary.withOpacity(0.3)),
                ),
                child: Center(
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 40,
                    color: scheme.primary,
                  ),
                ),
              ),
            );
          }

          final imageItem = _additionalImages[index];
          return Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: imageItem is File
                      ? Image.file(imageItem, fit: BoxFit.cover)
                      : Image.network(imageItem as String, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                top: 5,
                right: 12,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _additionalImages.removeAt(index);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(2),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _surfaceTile({IconData? icon, required String text, Widget? child}) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surface.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, color: scheme.primary),
          if (icon != null) const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color:
                    text ==
                        AppLocalizations.of(context)!.selectApartmentLocation
                    ? Colors.grey.shade600
                    : scheme.onBackground,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (child != null) child,
        ],
      ),
    );
  }
}
