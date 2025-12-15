import 'dart:async';
import 'package:daleel_app_project/models/apartments2.dart';
import 'package:daleel_app_project/models/user.dart';
import 'package:daleel_app_project/widget/apartment_widgets/most_popular_apartments_widget.dart';
import 'package:daleel_app_project/widget/apartment_widgets/nearpy_apartments_widgets.dart';
import '../../dependencies.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  final int _currentPage = 10000;
  late Future<List<Apartments2>?> _apartmentsFuture;

  @override
  void initState() {
    super.initState();

    _apartmentsFuture = apartmentController.loadApartments();

    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.7,
    );

    Timer.periodic(Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = userController.user;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 27,
              backgroundImage: (user != null && user.profileImage.isNotEmpty)
                  ? NetworkImage("http://10.0.2.2:8000${user.profileImage}")
                  : const AssetImage('assets/images/user.png') as ImageProvider,
            ),

            SizedBox(width: 15),
            Text(
              user != null
                  ? '${user.firstName} ${user.lastName}'
                  : 'any_name :)',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_outlined,
              color: Colors.brown,
              size: 32,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(174, 248, 245, 245),
                ),
                height: 48,
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.search,
                      size: 28,
                      color: Color.fromARGB(141, 121, 85, 72),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search Here...',
                          hintStyle: TextStyle(
                            color: Colors.brown.withAlpha((0.5 * 255).toInt()),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Most Popular',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                    ),
                    child: Text(
                      'See all',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.brown),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 215,
              child: FutureBuilder(
                future: _apartmentsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(child: Text('No apartments found'));
                  }

                  final apartments = snapshot.data!;

                  return PageView.builder(
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return carouselView(index, apartments);
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Close To You',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 12),

            FutureBuilder(
              future: _apartmentsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('No apartments found'));
                }

                final apartments = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: apartments.length,
                  itemBuilder: (context, index) {
                    return NearpyApartmentsWidgets(
                      apartment: apartments[index],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget carouselView(int index, List<Apartments2> apartments) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        num value = 0.0;

        if (_pageController.hasClients &&
            _pageController.position.haveDimensions) {
          value = (_pageController.page ?? _pageController.initialPage) - index;
          value = value.abs();
        }

        double scale = (1 - (value * 0.2)).clamp(0.6, 1.0);
        double opacity = (1 - (value * 0.5)).clamp(0.6, 1.0);

        return Transform.scale(
          scale: scale,
          child: Opacity(opacity: opacity, child: child),
        );
      },
      child: MostPopularApartmentsWidget(
        apartment: apartments[index % apartments.length],
      ),
    );
  }
}
