import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../dependencies.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final displayUser = userController.user!;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: scheme.onBackground),
        title: Text(
          AppLocalizations.of(context)!.profileDetails,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: scheme.onPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [scheme.primary, scheme.background],
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
                              color: scheme.shadow.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: scheme.surface,
                          backgroundImage: displayUser.profileImage.isNotEmpty
                              ? NetworkImage(baseUrl + displayUser.profileImage)
                              : const AssetImage('assets/images/user.png')
                                    as ImageProvider,
                        ),
                      ),
                      // Positioned(
                      //   bottom: 5,
                      //   right: 5,
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: scheme.primary,
                      //       shape: BoxShape.circle,
                      //       border: Border.all(color: scheme.surface, width: 2),
                      //     ),
                      // child: IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(
                      //     Icons.camera_alt_outlined,
                      //     color: scheme.onPrimary,
                      //   ),
                      // ),
                      //   ),
                      // ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     _imageColumn(
                //       context,
                //       title: AppLocalizations.of(context)!.personImage,
                //       imageUrl: baseUrl + displayUser.profileImage,
                //     ),
                //     _imageColumn(
                //       context,
                //       title: AppLocalizations.of(context)!.iDImage,
                //       imageUrl: baseUrl + displayUser.personIdImage,
                //     ),
                //   ],
                // ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      _buildDetailTile(
                        context,
                        icon: Icons.person_outline,
                        title: AppLocalizations.of(context)!.fullName,
                        subtitle:
                            '${displayUser.firstName} ${displayUser.lastName}',
                      ),
                      Divider(
                        color: scheme.onSurface.withOpacity(0.1),
                        indent: 20,
                        endIndent: 20,
                      ),
                      _buildDetailTile(
                        context,
                        icon: Icons.location_city,
                        title: AppLocalizations.of(context)!.city,
                        subtitle: displayUser.location!["city"],
                      ),
                      Divider(
                        color: scheme.onSurface.withOpacity(0.1),
                        indent: 20,
                        endIndent: 20,
                      ),
                      _buildDetailTile(
                        context,
                        icon: Icons.phone_outlined,
                        title: AppLocalizations.of(context)!.phoneNumber,
                        subtitle: displayUser.phone,
                        // ignore: unnecessary_null_comparison
                        isEditable: displayUser.phone != null,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // ElevatedButton(
                //   onPressed: () {},
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: scheme.surface,
                //     foregroundColor: scheme.primary,
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 50,
                //       vertical: 15,
                //     ),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(30),
                //     ),
                //     textStyle: const TextStyle(
                //       fontSize: 18,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   child: Text(AppLocalizations.of(context)!.editProfile),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageColumn(
    BuildContext context, {
    required String title,
    required String imageUrl,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          title,
          style: textTheme.bodyMedium?.copyWith(
            color: scheme.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 130,
          height: 160,
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: scheme.primary, width: 1.5),
          ),
          child: Image.network(imageUrl, fit: BoxFit.cover),
        ),
      ],
    );
  }

  Widget _buildDetailTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    bool isEditable = true,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      leading: Icon(icon, color: scheme.primary, size: 30),
      title: Text(
        title,
        style: textTheme.bodySmall?.copyWith(
          color: scheme.onSurface.withOpacity(0.6),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: scheme.onSurface,
        ),
      ),
      trailing: isEditable
          ? Icon(Icons.arrow_forward_ios, color: scheme.primary, size: 18)
          : null,
    );
  }
}
