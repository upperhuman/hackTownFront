import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../../dtos/event_route.dart';
import 'package:easy_localization/easy_localization.dart';

class GoogleMapsPage extends StatefulWidget {
  final EventRouteDTO routeData;
  GoogleMapsPage(this.routeData, {super.key});

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  static const cameraPosition = LatLng(48.46428963905694, 35.04401325135935);
  LatLng? currentPosition;
  Set<Polyline> _polylines = {};
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchLocationUpdates();
    });
  }

  String duration = "";
  String distance = "";
  List<String> steps = [];

  String duration = "";
  String distance = "";
  List<String> steps = [];

  Future<void> getData() async {
    try {
      final response = await http.get(
        Uri.parse('${dotenv.env["BASE_URL"]!}/api/EventRoutes/${widget.routeData.id}'),
        headers: {'Content-Type': 'application/json', 'ngrok-skip-browser-warning': '69420'},
      );
      final decodedResponse = utf8.decode(response.bodyBytes);
      Map<String, dynamic> responseData = jsonDecode(decodedResponse);

      List<dynamic> list = responseData["locations"];
      widget.routeData.locations.clear();
      for (var item in list) {
        widget.routeData.locations.add(LocationDTO.fromMap(item));
      }

      await _getRouteWithTraffic();
    } catch (e) {
      print('Error: $e');
    }
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
      throw Exception('Location permissions are permanently denied.');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      forceAndroidLocationManager: true, 
    );

    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });

    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(currentPosition!, 15.0),
    );

    print('Updated position: ${position.latitude}, ${position.longitude}');

    await _getRouteWithTraffic();
  } catch (e) {
    print('Error fetching location: $e');
  }
}

  Future<void> _getRouteWithTraffic() async {
  if (currentPosition == null || widget.routeData.locations.isEmpty) return;
  if (currentPosition == null || widget.routeData.locations.isEmpty) return;

  LatLng destination = LatLng(
    widget.routeData.locations.last.latitude,
    widget.routeData.locations.last.longitude,
  );
  LatLng destination = LatLng(
    widget.routeData.locations.last.latitude,
    widget.routeData.locations.last.longitude,
  );

  List<String> waypoints = widget.routeData.locations
      .sublist(0, widget.routeData.locations.length - 1)
      .map((loc) => '${loc.latitude},${loc.longitude}')
      .toList();

  final String baseUrl = 'https://maps.googleapis.com/maps/api/directions/json';
  final String url =
    '$baseUrl?origin=${currentPosition!.latitude},${currentPosition!.longitude}'
    '&destination=${destination.latitude},${destination.longitude}'
    '&mode=driving&traffic_model=best_guess&departure_time=now'
    '&language=uk'
    '&key=${dotenv.env["GOOGLE_MAP_API"]}'
    '${waypoints.isNotEmpty ? '&waypoints=${waypoints.join('|')}' : ''}';
  List<String> waypoints = widget.routeData.locations
      .sublist(0, widget.routeData.locations.length - 1)
      .map((loc) => '${loc.latitude},${loc.longitude}')
      .toList();

  final String baseUrl = 'https://maps.googleapis.com/maps/api/directions/json';
  final String url =
    '$baseUrl?origin=${currentPosition!.latitude},${currentPosition!.longitude}'
    '&destination=${destination.latitude},${destination.longitude}'
    '&mode=driving&traffic_model=best_guess&departure_time=now'
    '&language=uk'
    '&key=${dotenv.env["GOOGLE_MAP_API"]}'
    '${waypoints.isNotEmpty ? '&waypoints=${waypoints.join('|')}' : ''}';

  try {
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
  try {
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    if (data['status'] == 'OK') {
      List<LatLng> polylineCoordinates = [];
      PolylinePoints polylinePoints = PolylinePoints();
      List<PointLatLng> result = polylinePoints.decodePolyline(
        data['routes'][0]['overview_polyline']['points'],
      );
    if (data['status'] == 'OK') {
      List<LatLng> polylineCoordinates = [];
      PolylinePoints polylinePoints = PolylinePoints();
      List<PointLatLng> result = polylinePoints.decodePolyline(
        data['routes'][0]['overview_polyline']['points'],
      );

      for (var point in result) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      final leg = data['routes'][0]['legs'][0];
      for (var point in result) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      final leg = data['routes'][0]['legs'][0];

      setState(() {
        _polylines.clear();
        _polylines.add(
          Polyline(
            polylineId: const PolylineId("route_with_traffic"),
            color: Colors.blue,
            width: 6,
            points: polylineCoordinates,
          ),
        );

        duration = leg['duration']['text'];
        distance = leg['distance']['text'];
        steps.clear();
        for (var step in leg['steps']) {
          String instruction = step['html_instructions'];
          instruction = instruction.replaceAll(RegExp(r'<[^>]*>'), '');
          steps.add(instruction);
        }
      });
    } else {
      throw Exception('Failed to load route: ${data['status']}');
    }
  } catch (e) {
    print('Error fetching route: $e');
  }
}
      setState(() {
        _polylines.clear();
        _polylines.add(
          Polyline(
            polylineId: const PolylineId("route_with_traffic"),
            color: Colors.blue,
            width: 6,
            points: polylineCoordinates,
          ),
        );

        duration = leg['duration']['text'];
        distance = leg['distance']['text'];
        steps.clear();
        for (var step in leg['steps']) {
          String instruction = step['html_instructions'];
          instruction = instruction.replaceAll(RegExp(r'<[^>]*>'), '');
          steps.add(instruction);
        }
      });
    } else {
      throw Exception('Failed to load route: ${data['status']}');
    }
  } catch (e) {
    print('Error fetching route: $e');
  }
}

  Set<Marker> _getMarkers() {
    Set<Marker> markers = widget.routeData.locations
        .map((loc) => location(loc.latitude, loc.longitude))
        .toSet();

    if (currentPosition != null) {
      markers.add(
        Marker(
          markerId: const MarkerId("user_location"),
          position: currentPosition!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: "your_location".tr()),
        ),
      );
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: cameraPosition,
                zoom: 13,
              ),
              
              
              markers: _getMarkers(),
              polylines: _polylines,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 5),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("travel_time".tr() + ": $duration", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("distance".tr() + ": $distance", style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    Text("instructions".tr() + ":", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                      itemCount: steps.length,
                      itemBuilder: (context, index) {
                      return Text("• ${steps[index]}", style: TextStyle(fontSize: 14));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
          Positioned(
            left: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
              onPressed: () => Navigator.pop(context),
              iconSize: 45,
            ),
          ),
          /*Positioned(
            right: 0,
            child: IconButton(
              icon: Icon(Icons.account_circle_outlined, color: Theme.of(context).iconTheme.color),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserProfilePage()),
              ),
              iconSize: 45,
            ),
          ),*/
        ],
      ),
    );
  }
}

Marker location(double latitude, double longitude) {
  return Marker(
    markerId: MarkerId("location_${latitude}_$longitude"),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(latitude, longitude),
  );
}
