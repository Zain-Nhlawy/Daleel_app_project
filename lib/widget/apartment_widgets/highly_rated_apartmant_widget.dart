import 'dart:async';

import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/widget/apartment_widgets/most_popular_apartment_widget.dart';
import 'package:flutter/material.dart';

class HighlyRatedApartmentWidget extends StatefulWidget {
  const HighlyRatedApartmentWidget({super.key});

  @override
  State<HighlyRatedApartmentWidget> createState() =>
      _MostPopularApartmentsWidgetState();
}

class _MostPopularApartmentsWidgetState
    extends State<HighlyRatedApartmentWidget> {
  
  late PageController _pageController;
  final int _currentPage = 5;
  late Future<List<Apartments2>?> _apartmentsFuture;

  @override
  void initState() {
    super.initState();
    _apartmentsFuture = apartmentController.loadFilteredApartments(1, sort: "rentcounter_desc");

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
    return SizedBox(
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
              child: Center(child: Text(AppLocalizations.of(context)!.noApartmentsNearYou)),
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
      child: MostPopularApartmentWidget(
        apartment: apartments[index % apartments.length],
      ),
    );
  }
}
