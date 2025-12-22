import 'dart:async';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../dependencies.dart';
import '../../models/apartments.dart';
import '../../models/user.dart';
import '../../widget/apartment_widgets/most_popular_apartments_widget.dart';
import '../../widget/apartment_widgets/nearpy_apartments_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  final int _currentPage = 5;
  late Future<List<Apartments2>?> _apartmentsFuture;
  @override
  void initState() {
    super.initState();
    _apartmentsFuture = apartmentController.loadApartments();
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.7,
    );

    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = userController.user;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: (user != null && user.profileImage.isNotEmpty)
                  ? NetworkImage(baseUrl + user.profileImage)
                  : const AssetImage('assets/images/user.png') as ImageProvider,
            ),
            const SizedBox(width: 15),
            Text(
              user != null
                  ? '${user.firstName} ${user.lastName}'
                  : '${AppLocalizations.of(context)!.welcome}!',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 219, 155, 132),
              Color.fromARGB(255, 228, 228, 227),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black.withOpacity(0.15),
                    ),
                    height: 50,
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        const Icon(
                          Icons.search,
                          size: 28,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  '${AppLocalizations.of(context)!.searchHere}...',
                              hintStyle: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.mostPopular,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          overlayColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.seeAll,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 215,
                  child: FutureBuilder<List<Apartments2>?>(
                    future: _apartmentsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            '${AppLocalizations.of(context)!.error}: ${snapshot.error}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Text(
                            AppLocalizations.of(context)!.noApartmentsFound,
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      final apartments = snapshot.data!;
                      apartments.sort(
                        (a, b) =>
                            a.reviewCount!.compareTo(b.reviewCount as num),
                      );
                      if (apartments.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 100,
                            horizontal: 100,
                          ),
                          child: Center(child: Text("no apartments near you")),
                        );
                      }
                      var popularApartment = apartments;
                      if (apartments.length <= 10) {
                        popularApartment = apartments;
                      } else {
                        popularApartment = apartments.sublist(1, 10);
                      }
                      return PageView.builder(
                        physics: const ClampingScrollPhysics(),
                        controller: _pageController,
                        itemBuilder: (context, index) {
                          return carouselView(index, popularApartment);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    AppLocalizations.of(context)!.closeToYou,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                FutureBuilder<List<Apartments2>?>(
                  future: _apartmentsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${AppLocalizations.of(context)!.error}: ${snapshot.error}',
                        ),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)!.noApartmentsFound,
                        ),
                      );
                    }
                    final apartments = snapshot.data!;
                    final nearApartments = apartments
                        .where(
                          (apartment) =>
                              apartment.location!['city'] ==
                              user!.location!['city'],
                        )
                        .toList();
                    if (nearApartments.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 100,
                          horizontal: 100,
                        ),
                        child: Center(child: Text("no apartments near you")),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: nearApartments.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          child: NearpyApartmentsWidgets(
                            apartment: nearApartments[index],
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget carouselView(int index, List<Apartments2> apartments) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0.0;
        if (_pageController.position.haveDimensions) {
          value = (_pageController.page ?? 0) - index;
          value = (value.abs() * 0.2).clamp(0.0, 1.0);
        }
        return Transform.scale(
          scale: 1.0 - value,
          child: Opacity(opacity: (1.0 - value).clamp(0.6, 1.0), child: child),
        );
      },
      child: MostPopularApartmentsWidget(
        apartment: apartments[index % apartments.length],
      ),
    );
  }
}
