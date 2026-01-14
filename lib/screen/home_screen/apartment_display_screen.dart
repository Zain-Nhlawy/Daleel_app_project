import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/widget/apartment_widgets/nearpy_apartments_widgets.dart';
import 'package:flutter/material.dart';

class ApartmentsDisplayScreen extends StatefulWidget {
  final String? selectedCategory;
  final RangeValues? priceRange;
  final String? selectedProvince;
  final int? selectedRooms;
  final int? selectedBathrooms;
  final RangeValues? areaRange;

  const ApartmentsDisplayScreen({
    super.key,
    this.selectedCategory,
    this.priceRange,
    this.selectedProvince,
    this.selectedRooms,
    this.selectedBathrooms,
    this.areaRange,
  });

  @override
  State<ApartmentsDisplayScreen> createState() =>
      _ApartmentsDisplayScreenState();
}

class _ApartmentsDisplayScreenState extends State<ApartmentsDisplayScreen> {
  late Future<List<Apartments2>?> _myApartmentsFuture;
  int page = 1;
  @override
  void initState() {
    super.initState();

    _myApartmentsFuture = apartmentController.loadFilteredApartments(
      page,
      governorate: widget.selectedProvince,
      bedrooms: widget.selectedRooms,
      bathrooms: widget.selectedBathrooms,
      minArea: widget.areaRange?.start,
      maxArea: widget.areaRange?.end,
      minPrice: widget.priceRange?.start,
      maxPrice: widget.priceRange?.end,
    );
  }

  // Widget _buildFilterRow(String label, String value) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 4.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
  //         Text(
  //           value,
  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.filteredResults),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.background,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                Expanded(
                  child: FutureBuilder<List<Apartments2>?>(
                    future: _myApartmentsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            AppLocalizations.of(context)!.anErrorOccurred,
                          ),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Text(
                            AppLocalizations.of(
                              context,
                            )!.noApartmentsFoundForTheseFilters,
                          ),
                        );
                      }

                      final apartments = snapshot.data!;

                      /// 🔥 Sorting logic
                      if (widget.selectedCategory == "Popular") {
                        apartments.sort(
                          (a, b) => b.reviewCount!.compareTo(a.reviewCount!),
                        );
                      } else if (widget.selectedCategory == "Most Favorited") {
                        apartments.sort(
                          (a, b) => b.reviewCount!.compareTo(a.reviewCount!),
                        );
                      } else if (widget.selectedCategory == "Highly Rated") {
                        apartments.sort(
                          (a, b) =>
                              b.averageRating!.compareTo(a.averageRating!),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.only(bottom: 12),
                        itemCount: apartments.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: NearpyApartmentsWidgets(
                              apartment: apartments[index],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
