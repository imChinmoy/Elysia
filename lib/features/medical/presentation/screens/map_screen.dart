import 'dart:developer';
import 'package:client/core/constants.dart';
import 'package:client/core/themes.dart';
import 'package:client/features/medical/domain/entities/medical_place.dart';
import 'package:client/features/medical/presentation/controllers/nearby_location_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  Position? _currentPosition;
  GoogleMapController? _mapController;

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  /* ---------------- INIT ---------------- */

  Future<void> _initMap() async {
    try {
      await _requestLocationPermission();
      await _getCurrentLocation();
    } catch (e) {
      log('Init map error: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error initializing map: $e')));
      }
    }
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (!status.isGranted) {
      throw Exception('Location permission required');
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (!mounted) return;

      setState(() => _currentPosition = position);

      ref
          .read(nearbyMedicalPlacesProvider.notifier)
          .fetchNearbyPlaces(
            latitude: position.latitude,
            longitude: position.longitude,
          );

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          14,
        ),
      );
    } catch (e) {
      log('Get location error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to get current location')),
        );
      }
    }
  }

  Future<List<LatLng>> getRouteCoordinatesORS(
    LatLng origin,
    LatLng destination,
  ) async {
    try {
      final response = await _dio.post(
        'https://api.openrouteservice.org/v2/directions/driving-car',
        options: Options(
          headers: {
            'Authorization': ApiConfig.orsApiKey,
            'Accept':
                'application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8',
            'Content-Type': 'application/json; charset=utf-8',
          },
        ),
        data: {
          "coordinates": [
            [origin.longitude, origin.latitude],
            [destination.longitude, destination.latitude],
          ],
        },
      );

      log('ORS Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = response.data;

        final coordinates =
            data['features'][0]['geometry']['coordinates'] as List;

        final route = coordinates
            .map<LatLng>(
              (coord) => LatLng(
                (coord[1] as num).toDouble(),
                (coord[0] as num).toDouble(),
              ),
            )
            .toList();

        log('ORS Route points: ${route.length}');
        return route;
      } else {
        log('ORS HTTP error: ${response.statusCode}');
        log('ORS Body: ${response.data}');
      }
    } catch (e) {
      log('ORS Dio error: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to get route')));
      }
    }

    return [];
  }

  void _drawPolyline(List<LatLng> route) {
    if (route.isEmpty || !mounted) return;

    final polyline = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.blue,
      width: 5,
      points: route,
    );

    setState(() {
      _polylines = {polyline};
    });

    try {
      final bounds = _boundsFromLatLngList(route);
      _mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
    } catch (e) {
      log('Camera animation error: $e');
    }
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);

    double minLat = list.first.latitude;
    double maxLat = list.first.latitude;
    double minLng = list.first.longitude;
    double maxLng = list.first.longitude;

    for (final latLng in list) {
      if (latLng.latitude < minLat) minLat = latLng.latitude;
      if (latLng.latitude > maxLat) maxLat = latLng.latitude;
      if (latLng.longitude < minLng) minLng = latLng.longitude;
      if (latLng.longitude > maxLng) maxLng = latLng.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  void _updateMarkers(List<MedicalPlaceEntity> places) {
    final newMarkers = places.map((place) {
      return Marker(
        markerId: MarkerId(place.id),
        position: LatLng(place.location.latitude, place.location.longitude),
        infoWindow: InfoWindow(title: place.name, snippet: place.address),
        onTap: () => _showPlaceDetails(place),
      );
    }).toSet();

    if (!mounted) return;

    setState(() {
      _markers = newMarkers;
    });
  }

  void _showPlaceDetails(MedicalPlaceEntity place) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              place.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(place.address),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.directions),
              label: const Text('Navigate'),
              onPressed: () async {
                if (_currentPosition == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Location not available')),
                  );
                  return;
                }

                Navigator.pop(context);

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Getting route...')),
                  );
                }

                final origin = LatLng(
                  _currentPosition!.latitude,
                  _currentPosition!.longitude,
                );

                final destination = LatLng(
                  place.location.latitude,
                  place.location.longitude,
                );

                final route = await getRouteCoordinatesORS(origin, destination);

                if (route.isNotEmpty) {
                  _drawPolyline(route);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Route loaded')),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<List<MedicalPlaceEntity>>>(
      nearbyMedicalPlacesProvider,
      (_, next) {
        next.whenOrNull(data: _updateMarkers);
      },
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppThemes.gradient),
        child: _currentPosition == null
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    _currentPosition!.latitude,
                    _currentPosition!.longitude,
                  ),
                  zoom: 14,
                ),
                onMapCreated: (controller) => _mapController = controller,
                mapType: MapType.normal,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                markers: _markers,
                polylines: _polylines,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppThemes.doctorInfoBG,
        onPressed: _getCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
