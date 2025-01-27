import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VoiceInputScreen extends StatefulWidget {
  const VoiceInputScreen({super.key});

  @override
  _VoiceInputScreenState createState() => _VoiceInputScreenState();
}

class _VoiceInputScreenState extends State<VoiceInputScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "Press the button and start speaking";
  double _confidence = 1.0;

  final String serverUrl = 'https://36ec-51-20-191-32.ngrok-free.app/api/UserRequests';

  late GoogleMapController _mapController;
  Set<Marker> _markers = {};  // Set to hold the markers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Voice Input Screen')),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749, -122.4194),  // Default to San Francisco
                zoom: 12,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
              },
              markers: _markers,  // Display markers
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Confidence: ${(_confidence * 100).toStringAsFixed(1)}%',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  _text,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                FloatingActionButton(
                  onPressed: _listen,
                  child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    var micStatus = await Permission.microphone.status;
    if (!micStatus.isGranted) {
      await Permission.microphone.request();
    }

    var locationStatus = await Permission.location.status;
    if (!locationStatus.isGranted) {
      await Permission.location.request();
    }
  }

  void _listen() async {
    if (!_isListening) {
      try {
        bool available = await _speech.initialize(
          onStatus: (status) => print('Status: $status'),
          onError: (error) {
            print('Error: $error');
            _showSnackBar('Error: ${error.errorMsg}');
          },
        );
        if (available) {
          setState(() => _isListening = true);
          _speech.listen(
            onResult: (result) {
              print('Recognized words: ${result.recognizedWords}');
              setState(() {
                _text = result.recognizedWords;
                _confidence = result.confidence;
              });
              _sendDataToServer(_text);
            },
          );
        } else {
          _showSnackBar('Speech recognition is not available');
        }
      } catch (e) {
        print('Exception: $e');
        _showSnackBar('Error initializing speech recognition');
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  Future<void> _sendDataToServer(String text) async {
    final url = Uri.parse(serverUrl);
    _showSnackBar('Sending data to server...');

    try {
      final position = await _getCurrentPosition();
      final coords = '${position.latitude},${position.longitude}';

      final body = {
        "userId": 1,
        "coords": coords,
        "text": text
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print('Data sent successfully');
        _showSnackBar('Data sent successfully');
        
        final responseData = jsonDecode(response.body);
        
        if (responseData['routes'] != null) {
          List routes = responseData['routes'];
          print('Received routes: $routes');
          
          setState(() {
            _text = 'Received ${routes.length} routes';
            _markers.clear();  // Clear existing markers
          });

          // Add markers for each route
          for (var route in routes) {
            var lat = route['latitude'];
            var lng = route['longitude'];
            _addMarker(lat, lng);
          }
        } else {
          _showSnackBar('No routes found');
        }
      } else {
        print('Failed to send data: ${response.statusCode}, ${response.body}');
        _showSnackBar('Error sending data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      _showSnackBar('Connection error: $e');
    }
  }

  Future<Position> _getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  void _addMarker(double latitude, double longitude) {
    final marker = Marker(
      markerId: MarkerId('$latitude,$longitude'),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(title: 'Route Point'),
    );

    setState(() {
      _markers.add(marker);
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}