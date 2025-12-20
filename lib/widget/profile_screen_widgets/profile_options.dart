import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/screen/login_screen.dart';
import 'package:daleel_app_project/screen/profile_screens/profile_details_screen.dart';
import 'package:daleel_app_project/screen/tabs_screen/favorite_apartments_screen.dart';
import 'package:flutter/material.dart';
import '../../dependencies.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  void _setScreen(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => FavoriteApartmentsScreen()
      ),
    );
  }

  void _logout(BuildContext context) async {
    await userController.logout();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
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
                child: Icon(
                  Icons.person_outline,
                  size: 25,
                  color: Colors.brown,
                ),
              ),
              title: Text(
                textAlign: TextAlign.justify,
                AppLocalizations.of(context)!.profileDetails,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              trailing: Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileDetailsScreen(),
                  ),
                );
              },
            ),
          ),

          Card(
            color: Colors.transparent,
            elevation: 0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.home_outlined,
                  size: 25,
                  color: Colors.brown,
                ),
              ),
              title: Text(
                AppLocalizations.of(context)!.myHouses,
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
                  Icons.history_outlined,
                  size: 25,
                  color: Colors.brown,
                ),
              ),
              title: Text(
                AppLocalizations.of(context)!.contractsHistory,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right_outlined,
                color: Colors.black,
              ),
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
                  color: Colors.brown,
                ),
              ),
              title: Text(
                AppLocalizations.of(context)!.favorites,
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
                child: Icon(
                  Icons.settings_outlined,
                  size: 25,
                  color: Colors.brown,
                ),
              ),
              title: Text(
                AppLocalizations.of(context)!.settings,
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
                AppLocalizations.of(context)!.logout,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: Colors.red,
                ),
              ),
              trailing: Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {
                _logout(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
