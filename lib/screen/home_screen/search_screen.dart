import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/widget/apartment_widgets/nearpy_apartments_widgets.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({required this.search, super.key});
  final String search;
  @override
  State<SearchScreen> createState() => _ApartmentsDisplayScreenState();
}

class _ApartmentsDisplayScreenState extends State<SearchScreen> {
  late Future<List<Apartments2>?> _myApartmentsFuture;
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.search);
    _myApartmentsFuture = apartmentController.loadSearchedApartments(
      widget.search,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search result')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black.withOpacity(0.20),
                ),
                height: 50,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.search,
                      size: 28,
                      color: Color.fromARGB(223, 255, 255, 255),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          if (value.trim().isEmpty) return;

                          setState(() {
                            _myApartmentsFuture = apartmentController
                                .loadSearchedApartments(value);
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              '${AppLocalizations.of(context)!.searchHere}...',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(223, 255, 255, 255),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                    return const Center(child: Text('No apartments found '));
                  }
                  final apartments = snapshot.data!;

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
