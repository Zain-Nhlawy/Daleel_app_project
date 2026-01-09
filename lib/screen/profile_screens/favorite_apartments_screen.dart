// ignore_for_file: unused_element, use_build_context_synchronously, deprecated_member_use

import 'package:daleel_app_project/core/network/dio_client.dart';

import 'package:daleel_app_project/core/storage/secure_storage.dart';

import 'package:daleel_app_project/dependencies.dart';

import 'package:daleel_app_project/l10n/app_localizations.dart';

import 'package:daleel_app_project/models/apartments.dart';

import 'package:daleel_app_project/services/apartment_service.dart';

import 'package:daleel_app_project/widget/apartment_widgets/nearpy_apartments_widgets.dart';

import 'package:flutter/material.dart';

class FavoriteApartmentsScreen extends StatefulWidget {
  const FavoriteApartmentsScreen({super.key});

  @override
  State<FavoriteApartmentsScreen> createState() =>
      _FavoriteApartmentsScreenState();
}

class _FavoriteApartmentsScreenState extends State<FavoriteApartmentsScreen> {
  List<Apartments2> _favoriteApartments = [];
  final ScrollController _controller = ScrollController();
  bool _isLoading = true, _hasMore = true;
  int _page = 1;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchFavoriteApartments();
    _controller.addListener(() {
      if (_controller.position.pixels >=
              _controller.position.maxScrollExtent - 1 &&
          !_isLoading &&
          _hasMore) {
        _fetchFavoriteApartments();
      }
    });
  }

  Future<void> _fetchFavoriteApartments() async {
    try {
      final apartments = await apartmentController.loadFavouriteApartments(
        _page,
      );
      if (mounted) {
        setState(() {
          _favoriteApartments += apartments ?? [];
          if (apartments == null || apartments.isEmpty)
            _hasMore = false;
          else
            _page++;
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

  void _dismissApartment(Apartments2 apartment, int index) {
 
    final removedApartment = _favoriteApartments[index];
    setState(() {
      _favoriteApartments.removeAt(index);
    });
    final apartmentService = ApartmentService(
      apiClient: DioClient(storage: AppSecureStorage()),
    );
    apartmentService.toggleFavorite(apartment.id);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: Text(AppLocalizations.of(context)!.favouriteRemoved),
        action: SnackBarAction(
          label: AppLocalizations.of(context)!.undo,
          onPressed: () {
            setState(() {
              _favoriteApartments.insert(index, removedApartment);
            });
            apartmentService.toggleFavorite(apartment.id);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.favorites,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Text('${AppLocalizations.of(context)!.error}: $_error'),
      );
    }
    if (_favoriteApartments.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context)!.noApartmentsFound),
      );
    }
    return ListView.builder(
      controller: _controller,
      itemCount:
          _favoriteApartments.length +
          (_favoriteApartments.length >= 10 ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < _favoriteApartments.length) {
          final apartment = _favoriteApartments[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: NearpyApartmentsWidgets(apartment: apartment),
          );
        }
        if (_hasMore) {
          return const Padding(
            padding: EdgeInsets.all(10),
            child: Center(child: CircularProgressIndicator()),
          );
        } else {
          return const SizedBox(height: 10);
        }
      },
    );
  }
}
