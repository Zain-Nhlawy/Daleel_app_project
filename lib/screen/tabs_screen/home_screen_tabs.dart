import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/screen/chats_sceens/my_chats_screen.dart';
import 'package:daleel_app_project/screen/profile_screens/profile_screen.dart';
import 'package:daleel_app_project/screen/tabs_screen/adding_apartment_screen.dart';
import 'package:daleel_app_project/screen/tabs_screen/contract_screen.dart';
import 'package:flutter/material.dart';
import 'package:daleel_app_project/screen/home_screen/home_screen.dart';

class HomeScreenTabs extends StatefulWidget {
  const HomeScreenTabs({super.key});

  @override
  State<HomeScreenTabs> createState() => _MainScreenState();
}

class _MainScreenState extends State<HomeScreenTabs> {
  int _currentIndex = 0;

  final PageController _pageController = PageController();
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(),
      ContractScreen(),
      const AddingApartmentScreen(),
      const Center(child: MyChatsScreen()),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> arrayIcons = const [
      BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.handshake_outlined), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '')
    ];

    if(AppLocalizations.of(context)!.localeName == 'ar') {
      arrayIcons = arrayIcons.reversed.toList();
    }

    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 25,
        currentIndex: _currentIndex,
        selectedItemColor: const Color.fromARGB(255, 83, 55, 45),
        unselectedItemColor: const Color.fromARGB(255, 136, 125, 125),

        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            );
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handshake_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}
