import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/models/user.dart';
import 'package:daleel_app_project/widget/apartment_widgets/nearpy_apartments_widgets.dart';
import 'package:flutter/material.dart';

class CloseToYouApartmentsWidget extends StatefulWidget {
  CloseToYouApartmentsWidget({super.key, required this.controller});
  final ScrollController controller;

  @override
  State<CloseToYouApartmentsWidget> createState() =>
      _CloseToYouApartmentsWidgetState(controller: controller);
}

class _CloseToYouApartmentsWidgetState extends State<CloseToYouApartmentsWidget> {
  _CloseToYouApartmentsWidgetState({required this.controller});
  List<Apartments2> _apartments = [];
  final ScrollController controller;
  final User? user = userController.user;
  bool _isLoading = true, _hasMore = true;
  int _page = 1;
  String? _error;

  @override
  void initState() {
    super.initState();
    fetchApartments();

    controller.addListener((){
      if(controller.position.pixels >= controller.position.maxScrollExtent - 1 && !_isLoading && _hasMore) {
        fetchApartments();
      }
    });
  }

  Future<void> fetchApartments() async {
    try {
      final apartments = await apartmentController.loadFilteredApartments(_page, governorate: user!.location!['governorate']);
      if (mounted) {
        setState(() {
          _apartments += apartments ?? [];
          if(apartments == null || apartments.isEmpty) _hasMore = false;
          else _page++;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Text('${AppLocalizations.of(context)!.error}: $_error')
      );
    }

    if (_apartments.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context)!.noApartmentsFound)
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _apartments.length + 1,
      itemBuilder: (context, index) {
        if(index < _apartments.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            child: NearpyApartmentsWidgets(
              apartment: _apartments[index],
            )
          );
        }
        if(_hasMore) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        else {
          return const SizedBox(height: 10);
        }
      },
    );
  }
}
