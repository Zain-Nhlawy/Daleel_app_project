import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:flutter/material.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key, required Apartments2 this.apartment});

  final Apartments2 apartment;

  @override
  State<StatefulWidget> createState() {
    return _FavoriteWidgetState();
  }
}

class _FavoriteWidgetState extends State<FavoriteWidget> {

  void _handleFavoriteToggle() async {

    final sucess = await apartmentController.updateFavoriteApartments(widget.apartment.id);
    if(sucess) {
      setState(() {
        widget.apartment.toggle();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: Icon(
        widget.apartment.isFavorited!
            ? Icons.favorite
            : Icons.favorite_border,
        color: widget.apartment.isFavorited!
            ? colorScheme.error
            : colorScheme.onSurface,
        size: 22,
      ),
      onPressed: _handleFavoriteToggle,
    );
  }
}