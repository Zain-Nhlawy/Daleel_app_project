import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../dependencies.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final displayUser = userController.user;

    const Color primaryColor = Color.fromARGB(255, 219, 107, 66);
    const Color accentColor = Color.fromARGB(255, 228, 228, 227);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          AppLocalizations.of(context)!.profileDetails,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 219, 155, 132),
              Color.fromARGB(255, 228, 228, 227),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 120.0,
            ),
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              (displayUser!.profileImage.isNotEmpty)
                              ? NetworkImage(
                                       baseUrl+displayUser.profileImage,
                                )
                              : const AssetImage('assets/images/user.png')
                                    as ImageProvider,
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  '${displayUser.firstName} ${displayUser.lastName}',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      buildDetailTile(
                        context,
                        icon: Icons.person_outline,
                        title: AppLocalizations.of(context)!.fullName,
                        subtitle:
                            '${displayUser.firstName} ${displayUser.lastName}',
                        onTap: () {},
                        primaryColor: primaryColor,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(color: accentColor, thickness: 1),
                      ),
                      buildDetailTile(
                        context,
                        icon: Icons.email_outlined,
                        title: AppLocalizations.of(context)!.email,
                        subtitle: displayUser.email,
                        onTap: () {},
                        primaryColor: primaryColor,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(color: accentColor, thickness: 1),
                      ),
                      buildDetailTile(
                        context,
                        icon: Icons.phone_outlined,
                        title: AppLocalizations.of(context)!.phoneNumber,
                        subtitle: displayUser.phone,
                        onTap: () {},
                        // ignore: unnecessary_null_comparison
                        isEditable: displayUser.phone != null,
                        primaryColor: primaryColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text(AppLocalizations.of(context)!.editProfile),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetailTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Function()? onTap,
    bool isEditable = true,
    required Color primaryColor,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: primaryColor, size: 30),
      title: Text(
        title,
        style: TextStyle(color: Colors.grey[600], fontSize: 14),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.black87,
        ),
      ),
      trailing: (isEditable)
          ? Icon(Icons.arrow_forward_ios, color: primaryColor, size: 18)
          : null,
    );
  }
}

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String profileImage;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    required this.profileImage,
  });
}
