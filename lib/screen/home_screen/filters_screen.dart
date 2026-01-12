import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/screen/home_screen/apartment_display_screen.dart';
import 'package:flutter/material.dart';

class FilterBottomSheetContent extends StatelessWidget {
  const FilterBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    RangeValues priceRange = RangeValues(50, 5000);
    RangeValues areaRange = RangeValues(50, 500);
    String? selectedProvince;
    int? selectedRooms;
    int? selectedBathrooms;
    String? selectedCategory;

    final List<String> categories = [
      AppLocalizations.of(context)!.popular,
      AppLocalizations.of(context)!.highlyRated,
      AppLocalizations.of(context)!.mostFavorited,
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
      color: colorScheme.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.category,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8.0,
                          children: categories.map((category) {
                            return ChoiceChip(
                              label: Text(category),
                              selected: selectedCategory == category,
                              selectedColor: colorScheme.primary,
                              onSelected: (selected) {
                                setModalState(() {
                                  selectedCategory = selected ? category : null;
                                });
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          AppLocalizations.of(context)!.priceRange,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RangeSlider(
                          values: priceRange,
                          min: 50,
                          max: 5000,
                          divisions: 99,
                          activeColor: colorScheme.primary,
                          inactiveColor: colorScheme.onSurface.withOpacity(0.3),
                          labels: RangeLabels(
                            priceRange.start.round().toString(),
                            priceRange.end.round().toString(),
                          ),
                          onChanged: (values) =>
                              setModalState(() => priceRange = values),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          AppLocalizations.of(context)!.province,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropdownButtonFormField<String>(
                          value: selectedProvince,
                          hint: Text(
                            AppLocalizations.of(context)!.selectProvince,
                            style: textTheme.bodyMedium,
                          ),
                          items: syrianProvinces
                              .map(
                                (province) => DropdownMenuItem<String>(
                                  value: province,
                                  child: Text(
                                    province,
                                    style: textTheme.bodyMedium,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (newValue) =>
                              setModalState(() => selectedProvince = newValue),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.rooms,
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  DropdownButtonFormField<int>(
                                    value: selectedRooms,
                                    hint: Text(
                                      AppLocalizations.of(context)!.all,
                                      style: textTheme.bodyMedium,
                                    ),
                                    items: List.generate(10, (i) => i + 1)
                                        .map(
                                          (value) => DropdownMenuItem<int>(
                                            value: value,
                                            child: Text(
                                              value.toString(),
                                              style: textTheme.bodyMedium,
                                            ),
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
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.bathrooms,
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  DropdownButtonFormField<int>(
                                    value: selectedBathrooms,
                                    hint: Text(
                                      AppLocalizations.of(context)!.all,
                                      style: textTheme.bodyMedium,
                                    ),
                                    items: List.generate(5, (i) => i + 1)
                                        .map(
                                          (value) => DropdownMenuItem<int>(
                                            value: value,
                                            child: Text(
                                              value.toString(),
                                              style: textTheme.bodyMedium,
                                            ),
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
                        const SizedBox(height: 20),
                        Text(
                          "${AppLocalizations.of(context)!.areaRange} (${AppLocalizations.of(context)!.m2})",
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RangeSlider(
                          values: areaRange,
                          min: 30,
                          max: 1000,
                          divisions: 50,
                          activeColor: colorScheme.primary,
                          inactiveColor: colorScheme.onSurface.withOpacity(0.3),
                          labels: RangeLabels(
                            '${areaRange.start.round()} ${AppLocalizations.of(context)!.m2}',
                            '${areaRange.end.round()} ${AppLocalizations.of(context)!.m2}',
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
                      backgroundColor: scheme.primary,
                      foregroundColor: scheme.onPrimary,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(AppLocalizations.of(context)!.apply),
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
