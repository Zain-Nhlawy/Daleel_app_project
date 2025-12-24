import 'package:daleel_app_project/dependencies.dart';
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

  });

  @override
  State<ApartmentsDisplayScreen> createState() =>
      _ApartmentsDisplayScreenState();
}

class _ApartmentsDisplayScreenState extends State<ApartmentsDisplayScreen> {
  late Future<List<Apartments2>?> _myApartmentsFuture;

  @override
  void initState() {
    super.initState();

    _myApartmentsFuture = apartmentController.loadFilteredApartments(
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
      appBar: AppBar(title: Text('Filtered Results')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Applied Filters:',
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            // Divider(height: 20, thickness: 1),
            // _buildFilterRow('Category:', widget.selectedCategory ?? 'Any'),
            // _buildFilterRow(
            //   'Price Range:',
            //   '${widget.priceRange?.start.round() ?? '...'} - ${widget.priceRange?.end.round() ?? '...'}',
            // ),
            // _buildFilterRow('Province:', widget.selectedProvince ?? 'Any'),
            // _buildFilterRow(
            //   'Rooms:',
            //   widget.selectedRooms?.toString() ?? 'Any',
            // ),
            // _buildFilterRow(
            //   'Bathrooms:',
            //   widget.selectedBathrooms?.toString() ?? 'Any',
            // ),
            // _buildFilterRow(
            //   'Area (m²):',
            //   '${widget.areaRange?.start.round() ?? '...'} - ${widget.areaRange?.end.round() ?? '...'}',
            // ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Apartments2>?>(
                future: _myApartmentsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Center(child: Text('An error occurred!'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No apartments found for these filters.'),
                    );
                  }
                  final apartments = snapshot.data!;
                  if (widget.selectedCategory == "Popular") {
                    apartments.sort(
                      (a, b) => a.reviewCount!.compareTo(b.reviewCount as num),
                    );
                  } else if (widget.selectedCategory == "Most Favorited") {
                    if (widget.selectedCategory == "Popular") {
                      apartments.sort(
                        (a, b) =>
                            a.reviewCount!.compareTo(b.averageRating as num),
                      );
                    } else if (widget.selectedCategory == "Highly Rated") {
                      apartments.sort(
                        (a, b) =>
                            a.reviewCount!.compareTo(b.reviewCount as num),
                      );
                    }
                  }
                  return ListView.builder(
                    itemCount: apartments.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
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
    );
  }
}
