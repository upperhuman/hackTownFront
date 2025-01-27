import 'dart:async';
//import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;

import '../../dtos/event_route.dart';
import '../../pages/main_pages/user_profile_page.dart';

// GoogleMapsPage widget that displays a Google Map and handles user interactions
class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({super.key});

  //final EventRouteDTO routeData;
  //const GoogleMapsPage(this.routeData, {super.key});

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  static const LatLng initialCameraPosition = LatLng(48.46428963905694, 35.04401325135935);
  GoogleMapController? _mapController;
  LatLng? currentPosition;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    // Fetch the user's location updates after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) async => await fetchLocationUpdates());
    getData();
  }

  // Fetches event route data from the server and updates markers
  void getData() async {
    http.Response response;
    try {
      response = await http.get(
        Uri.parse('${dotenv.env["BASE_URL"]!}/api/EventRoutes/${widget.routeData.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
      );
      List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes)).cast<dynamic>();

      widget.routeData.locations.clear();
      for (var item in responseData) {
        widget.routeData.locations.add(LocationDTO.fromMap(item));
      }

      setState(() {
        markers.addAll(widget.routeData.locations.map((location) {
          return Marker(
            markerId: MarkerId(location.name),
            position: LatLng(location.latitude, location.longitude),
            infoWindow: InfoWindow(title: location.name, snippet: location.address),
          );
        }));
      });
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Gets the user's current location and updates the map
  Future<void> fetchLocationUpdates() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw Exception('Location services are disabled.');

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        _showLocationDialog();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        currentPosition = LatLng(position.latitude, position.longitude);
        markers.add(
          Marker(
            markerId: const MarkerId("current_location"),
            position: currentPosition!,
            infoWindow: const InfoWindow(title: "You are here"),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      });

      _animateToPosition(currentPosition!);
      _sendSelectedCoordinates(currentPosition!);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred: $e');
      }
    }
  }

  // Animates the camera to a given position
  void _animateToPosition(LatLng position) {
    _mapController?.animateCamera(CameraUpdate.newLatLngZoom(position, 15));
  }

  // Displays a dialog when location permissions are denied
  void _showLocationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location required'),
          content: const Text('You have not authorized access to the location. Select a point on the map manually.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('ОК'),
            ),
          ],
        );
      },
    );
  }

  // Handles user tapping on the map, adds a marker, and sends coordinates to the server
  void _onMapTapped(LatLng tappedPoint) {
    setState(() {
      markers.removeWhere((marker) => marker.markerId == const MarkerId("manual_location"));
      markers.add(
        Marker(
          markerId: const MarkerId("manual_location"),
          position: tappedPoint,
          infoWindow: const InfoWindow(title: "Selected location"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
      _animateToPosition(tappedPoint);
    });

    _sendSelectedCoordinates(tappedPoint);
  }

  // Sends selected coordinates to the server
  Future<void> _sendSelectedCoordinates(LatLng coords) async {
    print("Sending coordinates: ${coords.latitude}, ${coords.longitude}");
    try {
      final response = await http.post(
        Uri.parse('${dotenv.env["BASE_URL"]!}/api/EventRoutes/${widget.routeData.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
        body: jsonEncode({
          "coords": {
            "latitude": coords.latitude,
            "longitude": coords.longitude
          }
        }),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("Coordinates successfully sent to the server.");
        }
      } else {
        throw Exception("Failed to send coordinates: ${response.body}");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sending coordinates: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: initialCameraPosition,
              zoom: 13,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              fetchLocationUpdates();
            },
            onTap: _onMapTapped,
            markers: markers,
          ),
          Positioned(
            left: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
              onPressed: () => Navigator.pop(context),
              iconSize: 45,
            ),
          ),
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
}
