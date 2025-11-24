import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/images/profilePic.png'),
                ),
                SizedBox(height: 30),
                Text('Username', style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: 30),
                Card(
                  
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Icon(Icons.settings),
                    ),
                    title: Text('Headline'),
                    subtitle: Text('Supporting text'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
