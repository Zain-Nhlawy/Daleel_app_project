import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/models/user.dart';
import 'package:daleel_app_project/widget/apartment_widgets/nearpy_apartments_widgets.dart';
import 'package:flutter/material.dart';

class CloseToYouApartmentsWidget extends StatefulWidget {
  const CloseToYouApartmentsWidget({super.key, required this.controller});
  final ScrollController controller;

  @override
  State<CloseToYouApartmentsWidget> createState() =>
      _CloseToYouApartmentsWidgetState();
}

class _CloseToYouApartmentsWidgetState
    extends State<CloseToYouApartmentsWidget> {
  List<Apartments2> _apartments = [];
  final User? user = userController.user;
  bool _isInitialLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  int _page = 1;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchApartments();

    widget.controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (widget.controller.position.pixels >=
            widget.controller.position.maxScrollExtent - 100 &&
        !_isLoadingMore &&
        _hasMore) {
      _fetchApartments(loadMore: true);
    }
  }

  Future<void> _fetchApartments({bool loadMore = false}) async {
    try {
      if (loadMore) {
        setState(() => _isLoadingMore = true);
      } else {
        setState(() {
          _isInitialLoading = true;
          _error = null;
        });
      }

      final apartments = await apartmentController.loadFilteredApartments(
        _page,
        governorate: user?.location?['governorate'],
      );

      if (!mounted) return;

      setState(() {
        if (apartments == null || apartments.isEmpty) {
          _hasMore = false;
        } else {
          _apartments += apartments;
          _page++;
        }
        _isInitialLoading = false;
        _isLoadingMore = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isInitialLoading = false;
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitialLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Text(
          '${AppLocalizations.of(context)!.error}: ${AppLocalizations.of(context)!.errorFetchingApartment}',
        ),
      );
    }

    if (_apartments.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context)!.noApartmentsFound),
      );
    }

    return ListView.builder(
      controller: widget.controller,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _apartments.length + (_apartments.length >= 10 ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < _apartments.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: NearpyApartmentsWidgets(apartment: _apartments[index]),
          );
        }
        if (_hasMore) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Center(child: CircularProgressIndicator()),
          );
        } else {
          return const SizedBox(height: 10);
        }
      },
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scrollListener);
    super.dispose();
  }
}
