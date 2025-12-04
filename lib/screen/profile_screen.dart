import 'package:daleel_app_project/controllers/user_controller.dart';
import 'package:daleel_app_project/models/user.dart';
import 'package:daleel_app_project/widget/profile_screen_widgets/profile_options.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final UserController userController;
  const ProfileScreen({super.key, required this.userController});

  @override
  Widget build(BuildContext context) {
    final user = userController.user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 65,
                      backgroundImage: (user != null &&
                              user.profileImage.isNotEmpty)
                          ? NetworkImage(user.profileImage)
                          : const AssetImage('assets/images/user.png')
                              as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit, color: Colors.brown, size: 28),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user != null
                          ? '${user.firstName} ${user.lastName}'
                          : 'any_name :)',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'zainzain@gmail.com',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            ProfileOptions(),
          ],
        ),
      ),
    );
  }
}
