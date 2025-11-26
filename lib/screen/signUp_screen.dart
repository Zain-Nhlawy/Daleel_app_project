import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup2_screen.dart';
import '../widget/custom_text_field.dart';
import '../widget/upload_button.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  String? _profileImagePath;
  String? _idImagePath;

  bool showCard = false;


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => showCard = true);
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  Future<void> _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.brown,
              onPrimary: Colors.white,
              onSurface: Colors.brown,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.brown),
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      _dobController.text = "${date.year}-${date.month}-${date.day}";
    }
  }

  Future<void> _pickProfileImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() => _profileImagePath = image.path);
      } else {
        _showError("No profile image selected.");
      }
    } catch (e) {
      _showError("Error picking profile image.");
    }
  }

  Future<void> _pickIDImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() => _idImagePath = image.path);
      } else {
        _showError("No ID image selected.");
      }
    } catch (e) {
      _showError("Error picking ID image.");
    }
  }

  void _next() {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _dobController.text.isEmpty ||
        _profileImagePath == null ||
        _idImagePath == null) {
      _showError("Please fill all fields!");
      return;
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SignUp2Screen(),
        transitionDuration: const Duration(seconds: 1),
      ),
    );
  }


  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          controller: _firstNameController,
          label: "First Name",
          icon: Icons.person,
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _lastNameController,
          label: "Last Name",
          icon: Icons.person,
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _dobController,
          label: "Date of Birth",
          icon: Icons.cake,
          readOnly: true,
          onTap: _pickDate,
        ),
      ],
    );
  }

  Widget _buildUploadButtons() {
    return Row(
      children: [
        Expanded(
          child: UploadButton(
            text: "Profile Image",
            onPressed: _pickProfileImage,
            isUploaded: _profileImagePath != null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: UploadButton(
            text: "ID Image",
            onPressed: _pickIDImage,
            isUploaded: _idImagePath != null,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Center(
          child: SizedBox(
            width: 180,
            height: 55,
            child: OutlinedButton(
              onPressed: _next,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                "Next",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Already have an account?",
                style: TextStyle(color: Colors.white70),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              const LoginScreen(),
                      transitionDuration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/Background.jpg",
              fit: BoxFit.cover,
            ),
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
            bottom: showCard ? 0 : -700,
            left: 0,
            right: 0,
            child: Container(
              height: 700,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.7),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(40)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      "Join and explore",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildFormFields(),
                    const SizedBox(height: 16),
                    _buildUploadButtons(),
                    const SizedBox(height: 22),
                    _buildActionButtons(),
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
