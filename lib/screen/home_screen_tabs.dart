import 'package:flutter/material.dart';
import 'package:daleel_app_project/screen/home_screen.dart';

class HomeScreenTabs extends StatefulWidget {
  const HomeScreenTabs({super.key});

  @override
  State<HomeScreenTabs> createState() => _MainScreenState();
}

class _MainScreenState extends State<HomeScreenTabs> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const Center(child: Text('Rent a House')),
    const Center(child: Text('Add Apartment')),
    const Center(child: Text('Chat')),
    const Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        currentIndex: _currentIndex,
        
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.house), label: 'Rent'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
