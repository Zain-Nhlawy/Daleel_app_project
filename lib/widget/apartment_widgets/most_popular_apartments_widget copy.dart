import 'dart:async';
import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/widget/apartment_widgets/most_popular_apartment_widget.dart';
import 'package:flutter/material.dart';

class MostPopularApartmentsWidget extends StatefulWidget {
  const MostPopularApartmentsWidget({super.key});

  @override
  State<MostPopularApartmentsWidget> createState() =>
      _MostPopularApartmentsWidgetState();
}

class _MostPopularApartmentsWidgetState
    extends State<MostPopularApartmentsWidget> {
  late PageController _pageController;
  final int _currentPage = 10000;
  late Future<List<Apartments2>?> _apartmentsFuture;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _apartmentsFuture = apartmentController.loadFilteredApartments(
      1,
      sort: "rentcounter_desc",
    );

    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.7,
    );
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_pageController.hasClients && _pageController.positions.isNotEmpty) {
        final nextPage = _pageController.page!.toInt() + 1;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoScrollTimer?.cancel();
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

          final apartments = snapshot.data;
          if (apartments == null || apartments.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.noApartmentsFound,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          apartments.sort(
            (a, b) => (b.reviewCount ?? 0).compareTo(a.reviewCount ?? 0),
          );

          final popularApartments = apartments.length > 10
              ? apartments.sublist(0, 10)
              : apartments;

          return PageView.builder(
            physics: const ClampingScrollPhysics(),
            controller: _pageController,
            itemBuilder: (context, index) {
              return _carouselView(
                index,
                popularApartments[index % popularApartments.length],
              );
            },
          );
        },
      ),
    );
  }

  Widget _carouselView(int index, Apartments2 apartments) {
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
      child: MostPopularApartmentWidget(apartment: apartments),
    );
  }
}
