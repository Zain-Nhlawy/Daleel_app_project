import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../widget/custom_text_field.dart';
import '../data/governorates_data.dart';

class SignUp2Screen extends StatefulWidget {
  const SignUp2Screen({super.key});

  @override
  State<SignUp2Screen> createState() => _SignUp2ScreenState();
}

class _SignUp2ScreenState extends State<SignUp2Screen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  bool showCard = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 350), () {
      setState(() => showCard = true);
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _locationController.dispose();
    super.dispose();
  }


  void _signUp() {
    final phone = _phoneController.text.trim();
    final pass = _passwordController.text;
    final confirm = _confirmPasswordController.text;

    if (phone.isEmpty || pass.isEmpty || confirm.isEmpty) {
      _showError("Please fill all fields.");
      return;
    }

    if (pass != confirm) {
      _showError("Passwords do not match.");
      return;
    }

    print("Account Created!");
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void _pickLocation() {
    showDialog(
      context: context,
      builder: (context) {
        return LocationPickerDialog(
          onSelected: (city) {
            _locationController.text = city;
            Navigator.pop(context);
          },
        );
      },
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
              padding: EdgeInsets.only(top:1, left: 20),
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
            bottom: showCard ? 0 : -600,
            left: 0,
            right: 0,
            child: SignUpCard(
              phoneController: _phoneController,
              passwordController: _passwordController,
              confirmPasswordController: _confirmPasswordController,
              locationController: _locationController,
              onSignUp: _signUp,
              onPickLocation: _pickLocation,
            ),
          ),
        ],
      ),
    );
  }
}


class SignUpCard extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController locationController;
  final VoidCallback onSignUp;
  final VoidCallback onPickLocation;

  const SignUpCard({
    super.key,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.locationController,
    required this.onSignUp,
    required this.onPickLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 730,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.brown.withOpacity(0.7),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          const Text(
            "Create Account",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 28),
          CustomTextField(
            controller: phoneController,
            label: "Phone Number",
            keyboardType: TextInputType.phone,
            icon: Icons.phone,
          ),
          CustomTextField(
            controller: locationController,
            label: "Location",
            icon: Icons.location_on,
            readOnly: true,
            onTap: onPickLocation,
          ),
          CustomTextField(
            controller: passwordController,
            label: "Password",
            icon: Icons.lock,
            keyboardType: TextInputType.text,
            obscure: true,
          ),
          CustomTextField(
            controller: confirmPasswordController,
            label: "Confirm Password",
            icon: Icons.lock,
            keyboardType: TextInputType.text,
            obscure: true,
          ),
          const SizedBox(height: 30),
          Center(
            child: SizedBox(
              width: 180,
              height: 55,
              child: OutlinedButton(
                onPressed: onSignUp,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const LoginRedirect(),
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
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Select Your Location",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 8),
            const Divider(color: Colors.brown, thickness: 2),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: governorates.length,
                itemBuilder: (context, index) {
                  final city = governorates[index];
                  return ListTile(
                    title: Text(city, style: const TextStyle(color: Colors.brown)),
                    onTap: () => onSelected(city),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class LoginRedirect extends StatelessWidget {
  const LoginRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
                  builder: (context) => const LoginScreen(),
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
    );
  }
}