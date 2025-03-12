import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../dtos/event_route.dart';
import '../pages/route_page/route_page.dart';

class VoiceInputScreen extends StatefulWidget {
  const VoiceInputScreen({super.key});

  @override
  _VoiceInputScreenState createState() => _VoiceInputScreenState();
}

class _VoiceInputScreenState extends State<VoiceInputScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "start_speaking".tr();
  double _confidence = 1.0;
  bool shouldSendData = true;
  Timer? _debounce;

  final String serverUrl = '${dotenv.env["BASE_URL"]}/api/UserRequests';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
              onPressed: () => Navigator.pop(context),
              iconSize: 45,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "voice_confidence".tr() + ': ${(_confidence * 100).toStringAsFixed(1)}%',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  _text,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 70,
                  height: 70,
                  child: FloatingActionButton(
                    onPressed: _listen,
                    backgroundColor: Colors.white,
                    child: _isListening
                        ? Icon(Icons.mic, color: Colors.red, size: 40)
                        : Icon(Icons.mic_off, color: Colors.black, size: 40),
                  ),
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
        onStatus: (status) {
          print('Status: $status');
          if (status == 'done' && shouldSendData) {
            shouldSendData = false;
          }
        },
        onError: (error) {
          print('Error: $error');
          _showSnackBar('Error: ${error.errorMsg}');
        },
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
            _confidence = result.confidence;
          });
          _onSpeechResult(_text);
        });
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
    
    final body = {
      "userId": 1,  
      "coords": "${position.latitude},${position.longitude}",  
      "text": text.trim()  
    };

    print("Sending data: ${jsonEncode(body)}");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    print("Server response: ${response.body}");

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);


      List<dynamic> list = responseData["routes"];
      List<EventRouteDTO> routes = [];
      for (var item in list) {
        Map<String, dynamic> map = item;
        routes.add(EventRouteDTO.fromMap(map));
      }

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => RoutePage(routeData: routes)),
      );

    } else {
      _showSnackBar('Error sending data: ${response.statusCode}');
    }
  } catch (e) {
      _showSnackBar('Connection error: $e');
    }
  }

  void _onSpeechResult(String text) {
  if (!shouldSendData) return;
    shouldSendData = false; 
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(seconds: 3), () {
      _sendDataToServer(text);
    });
  }

  Future<Position> _getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}