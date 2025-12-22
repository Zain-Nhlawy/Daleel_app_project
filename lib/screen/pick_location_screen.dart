import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen({super.key});

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  final LatLng _center = LatLng(33.5138, 36.2765);
  final double _zoom = 9.0;

  LatLng? _selectedLatLng;

  String governorate = "Damascus Governorate";
  String city = "Unknown City";
  String street = "Unknown Street";
  String district = "Unknown district";

  final MapController _mapController = MapController();

  final LatLngBounds syriaBounds = LatLngBounds(
    LatLng(32.0, 35.5),
    LatLng(37.5, 42.0),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedLatLng = _center;
      _getAddressFromLatLng(_center);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.selectYourLocation),
        backgroundColor: Colors.brown,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _center,
              zoom: _zoom,
              maxZoom: 18,
              minZoom: 6,
              interactiveFlags: InteractiveFlag.all,
              onTap: (tapPosition, point) async {
                setState(() {
                  _selectedLatLng = point;
                });
                if (mounted) await _getAddressFromLatLng(point);
              },
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              if (_selectedLatLng != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _selectedLatLng!,
                      width: 50,
                      height: 50,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                        size: 40,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Card(
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$governorate - $city - $district - $street",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 40,
            right: 40,
            child: ElevatedButton(
              onPressed: () {
                if (_selectedLatLng == null) return;

                final location = {
                  "governorate": governorate,
                  "city": city,
                  "district": district,
                  "street": street,
                };

                Navigator.pop(context, location);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                "OK",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getAddressFromLatLng(LatLng pos) async {
    try {
      final url =
          'https://nominatim.openstreetmap.org/reverse?format=json&lat=${pos.latitude}&lon=${pos.longitude}&zoom=18&addressdetails=1&accept-language=en';

      final response = await Dio().get(
        url,
        options: Options(
          headers: {
            'User-Agent': 'MyFlutterApp/1.0 (myemail@gmail.com)',
            'Accept': 'application/json',
          },
        ),
      );
      final data = response.data['address'] ?? {};
      if (!mounted) return;
      setState(() {
        governorate = data['state'] ?? "Damascus Governorate";
        city = data['city'] ?? data['county'] ?? "Unknown city :(";
        district =
            data['suburb'] ?? data['neighbourhood'] ?? "Unknown district :(";
        street = data['road'] ?? "Unknown street :(";
      });
    } catch (e) {
      if (!mounted) return;
    }
  }
}
