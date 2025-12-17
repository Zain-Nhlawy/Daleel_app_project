import 'package:flutter/material.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/upload_button.dart';
import 'package:daleel_app_project/screen/login_screen.dart';

class SignUpPage1 extends StatelessWidget {
  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController dob;

  final String? profileImage;
  final String? idImage;

  final VoidCallback pickDate;
  final VoidCallback pickProfile;
  final VoidCallback pickID;
  final VoidCallback nextPage;

  const SignUpPage1({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.profileImage,
    required this.idImage,
    required this.pickDate,
    required this.pickProfile,
    required this.pickID,
    required this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 700,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.brown.withOpacity(0.7),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
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
                  fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 24),

            CustomTextField(
              controller: firstName,
              label: "First Name",
              icon: Icons.person,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 12),

            CustomTextField(
              controller: lastName,
              label: "Last Name",
              icon: Icons.person,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 12),

            CustomTextField(
              controller: dob,
              label: "Date of Birth",
              icon: Icons.cake,
              readOnly: true,
              onTap: pickDate,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: UploadButton(
                    text: "Profile Image",
                    isUploaded: profileImage != null,
                    onPressed: pickProfile,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: UploadButton(
                    text: "ID Image",
                    isUploaded: idImage != null,
                    onPressed: pickID,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Center(
              child: SizedBox(
                width: 180,
                height: 55,
                child: OutlinedButton(
                  onPressed: nextPage,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Next", style: TextStyle(fontSize: 20)),
                ),
              ),
            ),

            const SizedBox(height: 18),

            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, anim1, anim2) => const LoginScreen(),
                        transitionDuration: Duration(milliseconds: 600),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
