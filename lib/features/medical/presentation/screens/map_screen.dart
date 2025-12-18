import 'package:client/core/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initMap() async {
    await _requestLocationPermission();
    await _getCurrentLocation();
    _addMarkers();
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (!status.isGranted) {
      throw Exception(
        'Location permission is required to show nearby medical facilities',
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() => _currentPosition = position);
    debugPrint(_currentPosition.toString());
  }

  void _addMarkers() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppThemes.gradient),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              _currentPosition?.latitude ?? 28.4595,
              _currentPosition?.longitude ?? 77.0266,
            ),
            zoom: 14,
          ),
          mapType: MapType.normal,
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          markers: <Marker>{
            Marker(
              markerId: MarkerId('source'),
              position: LatLng(
                _currentPosition?.latitude ?? 28.4595,
                _currentPosition?.longitude ?? 77.0266,
              ),
            ),
            Marker(
              markerId: MarkerId('destination'),
              position: LatLng(28.4595, 77.0266),
            )
          },
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Navigate'),
        icon: Icon(Icons.directions_rounded),
      ),
    );
  }
}
