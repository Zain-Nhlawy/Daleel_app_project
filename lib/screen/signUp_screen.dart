import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/governorates_data.dart';
import '../widget/signup_widgets/signup_page1.dart';
import '../widget/signup_widgets/signup_page2.dart';
import 'package:daleel_app_project/screen/pick_location_screen.dart';
import '../../dependencies.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  String? _profileImagePath;
  String? _idImagePath;

  bool showCard = false;
  bool showSignUp2 = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() => showCard = true);
    });
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
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
      _showError("Please complete all fields");
      return;
    }

    setState(() => showSignUp2 = true);
  }

  void _signUp() async {
  if (_phoneController.text.isEmpty ||
      _passwordController.text.isEmpty ||
      _confirmPasswordController.text.isEmpty) {
    _showError("Missing fields");
    return;
  }

  if (_passwordController.text != _confirmPasswordController.text) {
    _showError("Passwords do not match");
    return;
  }

  if (_profileImagePath == null || _idImagePath == null) {
    _showError("Please select profile and ID images");
    return;
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
      location: _locationController.text,
    );

    if (user != null) {
      print("ACCOUNT CREATED: ${user.firstName} ${user.lastName}");
    } else {
      _showError("Registration failed");
    }
  } catch (e) {
    _showError("Error during registration: $e");
  }
}

void _pickLocation() async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const PickLocationScreen(),
    ),
  );

  if (result != null && result is String) {
    _locationController.text = result;
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/Background.jpg", fit: BoxFit.cover),
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

          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            bottom: showCard ? (showSignUp2 ? -700 : 0) : -700,
            left: 0,
            right: 0,
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

          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            bottom: showCard ? (showSignUp2 ? 0 : -700) : -700,
            left: 0,
            right: 0,
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
    );
  }
}

class LocationPickerDialog extends StatelessWidget {
  final Function(String) onSelected;

  const LocationPickerDialog({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 400,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text("Select Your Location", style: TextStyle(fontSize: 18)),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: governorates.length,
                itemBuilder: (_, i) => ListTile(
                  title: Text(governorates[i]),
                  onTap: () => onSelected(governorates[i]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
