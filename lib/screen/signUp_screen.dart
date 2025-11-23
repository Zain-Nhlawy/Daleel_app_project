import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../widget/custom_text_field.dart';
import '../widget/upload_button.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  bool showCard = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        showCard = true;
      });
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _signUp() {
    print(
        "First Name: ${_firstNameController.text}, Last Name: ${_lastNameController.text}, DOB: ${_dobController.text}");
  }

  void _pickProfileImage() {
    print("Pick Profile Image");
  }

  void _pickIDImage() {
    print("Pick ID Image");
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
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            bottom: showCard ? 0 : -700,
            left: 0,
            right: 0,
            child: Container(
              height: 650,
              padding: const EdgeInsets.all(24),
              decoration:  BoxDecoration(
                color:Colors.brown.withOpacity(0.7),

                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                boxShadow: [
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

                    CustomTextField(
                    controller: _firstNameController,
                    label: "First Name",
                    icon: Icons.person,
                  ),
                  CustomTextField(
                    controller: _lastNameController,
                    label: "Last Name",
                    icon: Icons.person_outline,
                  ),
                  CustomTextField(
                    controller: _dobController,
                    label: "Date of Birth",
                    icon: Icons.cake,
                  ),


                    const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: UploadButton(
                          text: "Profile Image",
                          onPressed: _pickProfileImage,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: UploadButton(
                          text: "ID Image",
                          onPressed: _pickIDImage,
                        ),
                      ),
                    ],
                  ),


                  const SizedBox(height: 22),


                    Center(
                    child: SizedBox(
                      width: 180,
                      height: 55,
                      child: OutlinedButton(
                        onPressed: _signUp,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.transparent,
                        ),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
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
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
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
