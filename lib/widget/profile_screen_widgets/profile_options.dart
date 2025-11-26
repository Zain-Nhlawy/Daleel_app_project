import 'package:daleel_app_project/screen/favorite_apartments_screen.dart';
import 'package:flutter/material.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  void _setScreen(context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => FavoriteApartmentsScreen()));
  }

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
                child: Icon(Icons.home_outlined, size: 25), // outlined
              ),
              title: Text(
                'My Houses',
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
                child: Icon(Icons.history_outlined, size: 25),
              ),
              title: Text(
                'Contracts History',
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
                child: Icon(Icons.favorite_outline, size: 25), // outlined
              ),
              title: Text(
                'Favorites',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              trailing: Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {
                _setScreen(context);
              },
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
                child: Icon(Icons.logout_outlined, size: 25, color: Colors.red),
              ),
              title: Text(
                textAlign: TextAlign.justify,
                'Logout',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: Colors.red,
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
