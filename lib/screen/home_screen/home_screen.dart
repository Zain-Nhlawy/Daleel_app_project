import 'dart:async';

import 'package:daleel_app_project/data/dummy_data.dart';
import 'package:daleel_app_project/data/me.dart';
import 'package:daleel_app_project/widget/apartment_widgets/most_popular_apartments_widget.dart';
import 'package:daleel_app_project/widget/apartment_widgets/nearpy_apartments_widgets.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final PageController _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.8,
  );

  @override
  Widget build(BuildContext context) {

    Timer.periodic(Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 8),
            CircleAvatar(
              radius: 27,
              backgroundImage: AssetImage(me.profileImage),
            ),
            SizedBox(width: 15),
            Text(me.name, style: Theme.of(context).textTheme.bodyLarge),
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
              child: PageView.builder(
                controller: _pageController,
                itemBuilder: (context, index) {
                  final realIndex = index % apartmentsList.length;

                  return MostPopularApartmentsWidget(
                    apartment: apartmentsList[realIndex],
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

            Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: apartmentsList.length,
                itemBuilder: (context, index) =>
                    NearpyApartmentsWidgets(apartment: apartmentsList[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
