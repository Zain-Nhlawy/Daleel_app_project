import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/screen/pick_location_screen.dart';
import 'package:daleel_app_project/widget/signup_widgets/signup_page1.dart';
import 'package:daleel_app_project/widget/signup_widgets/signup_page2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  String? _profileImagePath;
  String? _idImagePath;
  Map<String, dynamic>? selectedLocation;

  bool showCard = false;
  bool showSignUp2 = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() => showCard = true);
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), backgroundColor: Colors.red));
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      _dobController.text = "${date.year}-${date.month}-${date.day}";
    }
  }

  Future<void> _pickProfileImage() async {
    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null) setState(() => _profileImagePath = img.path);
  }

  Future<void> _pickIDImage() async {
    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null) setState(() => _idImagePath = img.path);
  }

  void _next() {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _dobController.text.isEmpty ||
        _profileImagePath == null ||
        _idImagePath == null) {
      _showError(AppLocalizations.of(context)!.pleaseFillAllFields);
      return;
    }

    setState(() {
      showSignUp2 = true;
      _animationController.forward(from: 0);
    });
  }

  void _backToPage1() {
    setState(() {
      showSignUp2 = false;
      _animationController.forward(from: 0);
    });
  }

  Future<bool> _signUp() async {
    if (_phoneController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showError(AppLocalizations.of(context)!.missingFields);
      return false;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showError(AppLocalizations.of(context)!.passwordsDoNotMatch);
      return false;
    }

    if (_profileImagePath == null || _idImagePath == null) {
      _showError(AppLocalizations.of(context)!.pleaseSelectProfileAndIDImages);
      return false;
    }
    if (selectedLocation == null) {
      _showError("Please select location");
      return  false;
    }

    try {
      final user = await userController.register(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        profileImage: _profileImagePath!,
        personIdImage: _idImagePath!,
        birthdate: _dobController.text,
        location: selectedLocation!,
      );

      if (user != null) {
      print("ACCOUNT CREATED: ${user.firstName} ${user.lastName}");
      return true; 
    } else {
      _showError(AppLocalizations.of(context)!.registrationFailed);
      return false;
    }
  } catch (e) {
    _showError("Error during registration: $e");
    return false;
  }
}

  void _pickLocation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const PickLocationScreen(),
      ),
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
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child:
                Image.asset("assets/images/Background.jpg", fit: BoxFit.cover),
          ),
          const SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 1, left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Image(
                  image: AssetImage("assets/images/daleelLogo.png"),
                  width: 130,
                  height: 130,
                ),
              ),
            ),
          ),

          if (!showSignUp2)
            Positioned(
              top: 160,
              left: 0,
              right: 0,
              bottom: 0,
              child: SlideTransition(
                position: _slideAnimation,
                child: SignUpPage1(
                  firstName: _firstNameController,
                  lastName: _lastNameController,
                  dob: _dobController,
                  profileImage: _profileImagePath,
                  idImage: _idImagePath,
                  pickDate: _pickDate,
                  pickProfile: _pickProfileImage,
                  pickID: _pickIDImage,
                  nextPage: _next,
                ),
              ),
            ),

          if (showSignUp2)
            Positioned(
              top: 160,
              left: 0,
              right: 0,
              bottom: 0,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.brown),
                            onPressed: _backToPage1,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Back",
                            style: TextStyle(
                              color: Colors.brown,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SignUpPage2(
                        phone: _phoneController,
                        password: _passwordController,
                        confirmPassword: _confirmPasswordController,
                        location: _locationController,
                        pickLocation: _pickLocation,
                        signUp: _signUp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
