import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  _GoogleMapPage createState() => _GoogleMapPage();
}

class _GoogleMapPage extends State<GoogleMapPage> {
  late GoogleMapController mapscontroller;

  List<Marker> _markers = [];
  bool showMaps = true;

  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
      markerId: MarkerId("My Location"),
      position: LatLng(48.4655, 35.054)
    ));
    if(_markers.isNotEmpty) {
      setState(() {
        showMaps = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: showMaps 
      ? Container(
        height: 300,
        width: 1200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12)
        ),
        child: GoogleMap(
          onMapCreated: (controller) {
            setState(() {
            mapscontroller = controller;
            });
          },
          markers: Set<Marker>.of(_markers),
          mapType: MapType.terrain,
          initialCameraPosition: CameraPosition(target: LatLng(48.4655, 35.054), zoom: 13),
        ),
      )
      : CircularProgressIndicator(
        color: Colors.amber,
      ) 
    );
  }
}
