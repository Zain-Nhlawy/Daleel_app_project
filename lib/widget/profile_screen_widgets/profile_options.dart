import 'package:flutter/material.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            color: Colors.transparent,
            elevation: 0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.person_outline, size: 25),
              ),
              title: Text(
                textAlign: TextAlign.justify,
                'Profile Details',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              trailing: Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {},
            ),
          ),

          Card(
            color: Colors.transparent,
            elevation: 0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.settings_outlined, size: 25),
              ),
              title: Text(
                'Settings',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              trailing: Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {},
            ),
          ),

          Card(
            color: Colors.transparent,
            elevation: 0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.home_outlined, size: 25), // outlined
              ),
              title: Text(
                'Listed Houses for Rent',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              trailing: Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {},
            ),
          ),

          Card(
            color: Colors.transparent,
            elevation: 0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.favorite_outline,
                  size: 25,
                  color: Colors.red,
                ), // outlined
              ),
              title: Text(
                'Favorites',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              trailing: Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {},
            ),
          ),

          Card(
            color: Colors.transparent,
            elevation: 0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.logout_outlined, size: 25, color: Colors.red),
              ),
              title: Text(
                textAlign: TextAlign.justify,
                'Logout',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              trailing: Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
