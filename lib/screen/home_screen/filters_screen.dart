import 'package:daleel_app_project/screen/home_screen/apartment_display_screen.dart';
import 'package:flutter/material.dart';

class FilterBottomSheetContent extends StatelessWidget {
  const FilterBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    RangeValues priceRange = RangeValues(50, 5000);
    RangeValues areaRange = RangeValues(50, 500);
    String? selectedProvince;
    int? selectedRooms;
    int? selectedBathrooms;
    String? selectedCategory;

    final List<String> categories = [
      'Popular',
      'Highly Rated',
      'Most Favorited',
    ];
    final List<String> syrianProvinces = [
      'Damascus',
      'Rif Dimashq',
      'Aleppo',
      'Homs',
      'Hama',
      'Latakia',
      'Tartus',
      'Deir ez-Zor',
      'Al-Hasakah',
      'Raqqa',
      'Idlib',
      'As-Suwayda',
      'Daraa',
      'Quneitra',
    ];

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Wrap(
                          spacing: 8.0,
                          children: categories.map((category) {
                            return ChoiceChip(
                              label: Text(category),
                              selected: selectedCategory == category,
                              onSelected: (selected) {
                                setModalState(() {
                                  selectedCategory = selected ? category : null;
                                });
                              },
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Price Range',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RangeSlider(
                          values: priceRange,
                          min: 50,
                          max: 5000,
                          divisions: 99,
                          labels: RangeLabels(
                            priceRange.start.round().toString(),
                            priceRange.end.round().toString(),
                          ),
                          onChanged: (values) =>
                              setModalState(() => priceRange = values),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Province',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropdownButtonFormField<String>(
                          value: selectedProvince,
                          hint: Text('Select Province'),
                          items: syrianProvinces
                              .map(
                                (province) => DropdownMenuItem<String>(
                                  value: province,
                                  child: Text(province),
                                ),
                              )
                              .toList(),
                          onChanged: (newValue) =>
                              setModalState(() => selectedProvince = newValue),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rooms',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  DropdownButtonFormField<int>(
                                    value: selectedRooms,
                                    hint: Text('All'),
                                    items: List.generate(10, (i) => i + 1)
                                        .map(
                                          (value) => DropdownMenuItem<int>(
                                            value: value,
                                            child: Text(value.toString()),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (newValue) => setModalState(
                                      () => selectedRooms = newValue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bathrooms',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  DropdownButtonFormField<int>(
                                    value: selectedBathrooms,
                                    hint: Text('All'),
                                    items: List.generate(5, (i) => i + 1)
                                        .map(
                                          (value) => DropdownMenuItem<int>(
                                            value: value,
                                            child: Text(value.toString()),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (newValue) => setModalState(
                                      () => selectedBathrooms = newValue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Area Range (m²)',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RangeSlider(
                          values: areaRange,
                          min: 30,
                          max: 1000,
                          divisions: 50,
                          labels: RangeLabels(
                            '${areaRange.start.round()} m²',
                            '${areaRange.end.round()} m²',
                          ),
                          onChanged: (values) =>
                              setModalState(() => areaRange = values),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 16,
                    bottom: 16 + MediaQuery.of(context).padding.bottom,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text('Apply'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApartmentsDisplayScreen(
                            selectedCategory: selectedCategory,
                            priceRange: priceRange,
                            selectedProvince: selectedProvince,
                            selectedRooms: selectedRooms,
                            selectedBathrooms: selectedBathrooms,
                            areaRange: areaRange,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
