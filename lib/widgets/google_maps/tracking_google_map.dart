import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../pages/main_pages/user_profile_page.dart';

class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({super.key});

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  static const cameraPosition = LatLng(48.46428963905694, 35.04401325135935);
  static const theFirstPoint = LatLng(48.465283363388544, 35.04606230572078);
  static const theSecondPoint = LatLng(48.46352772173403, 35.07182895404438);

  LatLng? currentPosition;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
    .addPostFrameCallback((_) async => await fetchLocationUpdates());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Google Map
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: cameraPosition, 
                zoom: 13,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("sourceLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: theFirstPoint,
                ),
                Marker(
                  markerId: MarkerId("sourceLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: theSecondPoint,
                ),
              },
            ),
          ),
          
          // Back button
          Positioned(
            left: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 45,
            ),
          ),
          
          // User profile button
          Positioned(
            right: 0,
            child: IconButton(
              icon: Icon(Icons.account_circle_outlined, color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const UserProfilePage()),
                );
              },
              iconSize: 45,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchLocationUpdates() async {
  try {

  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled.');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied.');
    }
  }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // Получаем текущее местоположение
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        currentPosition = LatLng(position.latitude, position.longitude);
      });

      print('Current position: $currentPosition');
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}