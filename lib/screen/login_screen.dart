import 'package:daleel_app_project/controllers/user_controller.dart';
import 'package:daleel_app_project/core/storage/secure_storage.dart';
import 'package:daleel_app_project/core/network/dio_client.dart';
import 'package:daleel_app_project/screen/tabs_screen/home_screen_tabs.dart';
import 'package:daleel_app_project/services/user_service.dart';
import 'package:flutter/material.dart';
import 'signUp_screen.dart';
import '../widget/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showCard = false;

  late UserService userService;
  late UserController userController; 

  @override
  void initState() {
    super.initState();

    userService = UserService(
      apiClient: DioClient(storage: AppSecureStorage()),
      storage: AppSecureStorage(),
    );

    userController = UserController(
      userService: userService,
      storage: AppSecureStorage(),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        showCard = true;
      });
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.redAccent),
    );
  }

  void _login() async {
    final phone = _phoneController.text.trim();
    final password = _passwordController.text;

    if (phone.isEmpty || password.isEmpty) {
      _showError("Please fill all fields.");
      return;
    }

    final loggedUser = await userController.login(phone, password);

    if (loggedUser == null) {
      _showError("Login failed. Check your credentials.");
      return;
    }

    print("Logged in user: ${loggedUser.firstName}");

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, anim1, anim2) => HomeScreenTabs(userController: userController),
        transitionDuration: const Duration(seconds: 1),
      ),
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
          const _HeaderLogo(),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            bottom: showCard ? 0 : -500,
            left: 0,
            right: 0,
            child: LoginCard(
              phoneController: _phoneController,
              passwordController: _passwordController,
              onLogin: _login,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderLogo extends StatelessWidget {
  const _HeaderLogo();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
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
    );
  }
}

class LoginCard extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;

  const LoginCard({
    required this.phoneController,
    required this.passwordController,
    required this.onLogin,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.brown.withOpacity(0.7),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, -4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          const Text(
            "Welcome back!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: phoneController,
            label: "Phone Number",
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
          ),
          CustomTextField(
            controller: passwordController,
            label: "Password",
            icon: Icons.lock,
            keyboardType: TextInputType.text,
            obscure: true,
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 180,
              height: 55,
              child: OutlinedButton(
                onPressed: onLogin,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const _SignUpLink(),
        ],
      ),
    );
  }
}

class _SignUpLink extends StatelessWidget {
  const _SignUpLink();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Don't have an account?", style: TextStyle(color: Colors.white70)),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, anim1, anim2) => const SignUpScreen(),
                transitionDuration: const Duration(seconds: 1),
              ),
            ),
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
