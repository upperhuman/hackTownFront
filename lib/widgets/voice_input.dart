import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  String _text = "Press the button and start speaking";
  double _confidence = 1.0;
  bool shouldSendData = true;  // Добавляем флаг
  Timer? _debounce;
  Set<Polyline> _polylines = {};  // Хранение маршрутов

  final String serverUrl = '${dotenv.env["BASE_URL"]}/api/UserRequests';

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
                target: LatLng(48.46475934204965, 35.043675852637755), // Текущая позиция
                zoom: 12,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
              },
              markers: _markers,
              polylines: _polylines, // Показываем маршрут
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
        onStatus: (status) {
          print('Status: $status');
          if (status == 'done' && shouldSendData) {
            _sendDataToServer(_text);
            shouldSendData = false;  // Блокируем повторную отправку
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

    print("Отправляем данные: ${jsonEncode(body)}");

    // Отправка данных на сервер
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    print("Ответ сервера: ${response.body}");

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

Future<void> _fetchRoute(int routeId) async {
  final routeUrl = Uri.parse('${dotenv.env["BASE_URL"]!}/api/EventRoutes/$routeId');
  print("Запрашиваем маршрут: $routeUrl");

  try {
    final response = await http.get(routeUrl);

    // Проверка кода ответа
    if (response.statusCode == 200) {
      // Если статус 200, выводим содержимое ответа
      print('Ответ от сервера: ${response.body}');
      
      // Далее, можно попытаться разобрать ответ и посмотреть его структуру
      var responseData = jsonDecode(response.body);
      print('Данные из JSON: $responseData');
      
      // Пример получения локаций
      if (responseData['locations'] != null) {
        print('Локации: ${responseData['locations']}');
      } else {
        print('Нет данных о локациях');
      }
    } else {
      // В случае ошибки на сервере
      print('Ошибка запроса: ${response.statusCode}');
    }
  } catch (e) {
    print('Ошибка запроса: $e');
  }
}

void _drawRoute(List<LatLng> routePoints) {
  final polyline = Polyline(
    polylineId: PolylineId('route_${DateTime.now().millisecondsSinceEpoch}'),
    color: Colors.blue,
    width: 5,
    points: routePoints,
  );

  setState(() {
    _polylines.clear();  // Удаляем старые маршруты
    _polylines.add(polyline);
    _moveCameraToRoute(routePoints);  // Перемещаем камеру
  });
}

void _moveCameraToRoute(List<LatLng> routePoints) {
  if (routePoints.isNotEmpty) {
    _mapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        _getBounds(routePoints),
        50, // Отступ
      ),
    );
  }
}

LatLngBounds _getBounds(List<LatLng> points) {
  double minLat = points.first.latitude;
  double minLng = points.first.longitude;
  double maxLat = points.first.latitude;
  double maxLng = points.first.longitude;

  for (LatLng point in points) {
    if (point.latitude < minLat) minLat = point.latitude;
    if (point.longitude < minLng) minLng = point.longitude;
    if (point.latitude > maxLat) maxLat = point.latitude;
    if (point.longitude > maxLng) maxLng = point.longitude;
  }

  return LatLngBounds(
    southwest: LatLng(minLat, minLng),
    northeast: LatLng(maxLat, maxLng),
  );
}


  void _onSpeechResult(String text) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(seconds: 3), () {
      _sendDataToServer(text);
    });
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