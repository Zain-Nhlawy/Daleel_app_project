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
      const ContractScreen(),
      const AddingApartmentScreen(),
      const Center(child: MyChatsScreen()),
      const ProfileScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //  final colorScheme = theme.colorScheme;

    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: _buildModernNavBar(theme),
    );
  }

  Widget _buildModernNavBar(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        height: 60,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildNavItem(icon: Icons.explore_outlined, index: 0, theme: theme),
            _buildNavItem(
              icon: Icons.handshake_outlined,
              index: 1,
              theme: theme,
            ),
            _buildCenterFab(theme),
            _buildNavItem(icon: Icons.chat_outlined, index: 3, theme: theme),
            _buildNavItem(icon: Icons.person_outline, index: 4, theme: theme),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required ThemeData theme,
  }) {
    final isActive = _currentIndex == index;
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(30),
      splashColor: colorScheme.primary.withOpacity(0.1),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive
              ? colorScheme.primaryContainer.withOpacity(0.5)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          icon,
          size: 26,
          color: isActive
              ? colorScheme.primary
              : colorScheme.onSurface.withOpacity(0.4),
        ),
      ),
    );
  }

  Widget _buildCenterFab(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () => _onItemTapped(2),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: colorScheme.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withOpacity(0.4),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(Icons.add, color: colorScheme.onPrimary, size: 28),
      ),
    );
  }
}
