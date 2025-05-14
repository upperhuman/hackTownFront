import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  bool _isLoading = false;
  String _text = "start_speaking".tr();
  double _confidence = 1.0;
  Timer? _debounce;
  bool _permissionsGranted = false;

  final String serverUrl = '${dotenv.env["BASE_URL"]}/api/UserRequests';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: SafeArea(
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
                onPressed: () => Navigator.pop(context),
                iconSize: 45,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${"voice_confidence".tr()}: ${(_confidence * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    _text,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const SpinKitFadingCircle(
                  size: 70,
                  color: Colors.black,
                )
                    : SizedBox(
                  width: 70,
                  height: 70,
                  child: FloatingActionButton(
                    onPressed: _permissionsGranted ? _listen : _checkAndRequestPermissions,
                    backgroundColor: Colors.white,
                    child: _isListening
                        ? const Icon(Icons.mic, color: Colors.red, size: 40)
                        : const Icon(Icons.mic_off, color: Colors.black, size: 40),
                  ),
                ),
                if (!_permissionsGranted)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "permission_required".tr(),
                      style: const TextStyle(color: Colors.red),
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
    _checkAndRequestPermissions();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _speech.cancel();
    super.dispose();
  }

  Future<void> _checkAndRequestPermissions() async {
    bool allGranted = true;

    // Check microphone permission
    var micStatus = await Permission.microphone.status;
    if (!micStatus.isGranted) {
      final micResult = await Permission.microphone.request();
      if (!micResult.isGranted) {
        allGranted = false;
        _showPermissionDeniedDialog("microphone");
      }
    }

    // Check location permission
    var locationStatus = await Permission.location.status;
    if (!locationStatus.isGranted) {
      final locationResult = await Permission.location.request();
      if (!locationResult.isGranted) {
        allGranted = false;
        _showPermissionDeniedDialog("location");
      }
    }

    setState(() {
      _permissionsGranted = allGranted;
    });

    if (allGranted) {
      // Initialize speech recognition after permissions are granted
      bool available = await _initializeSpeech();
      if (!available) {
        _showSnackBar('Speech recognition is not available on this device');
      }
    }
  }

  void _showPermissionDeniedDialog(String permission) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${permission}_permission_required'.tr()),
        content: Text('${permission}_permission_explanation'.tr()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
            child: Text('open_settings'.tr()),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('cancel'.tr()),
          ),
        ],
      ),
    );
  }

  Future<bool> _initializeSpeech() async {
    try {
      return await _speech.initialize(
        onStatus: (status) {
          print('Speech status: $status');
          if (status == 'done' || status == 'notListening') {
            if (_isListening) {
              setState(() => _isListening = false);
              if (_text.isNotEmpty && _text != "start_speaking".tr()) {
                _processSpeechResult();
              }
            }
          }
        },
        onError: (errorNotification) {
          print('Speech error: ${errorNotification.errorMsg}');
          setState(() => _isListening = false);
          _showSnackBar('Recognition error: ${errorNotification.errorMsg}');
        },
      );
    } catch (e) {
      print('Speech initialization error: $e');
      _showSnackBar('Failed to initialize speech recognition');
      return false;
    }
  }

  void _listen() async {
    if (!_permissionsGranted) {
      await _checkAndRequestPermissions();
      return;
    }

    if (!_isListening) {
      setState(() {
        _text = "listening".tr();
        _confidence = 1.0;
      });

      try {
        if (await _speech.initialize()) {
          setState(() => _isListening = true);

          await _speech.listen(
            onResult: (result) {
              setState(() {
                if (result.recognizedWords.isNotEmpty) {
                  _text = result.recognizedWords;
                  _confidence = result.confidence > 0 ? result.confidence : _confidence;
                }
              });
            },
            listenFor: const Duration(seconds: 30),
            pauseFor: const Duration(seconds: 3),
            partialResults: true,
            cancelOnError: true,
            listenMode: stt.ListenMode.confirmation,
          );
        } else {
          _showSnackBar('Speech recognition could not be initialized');
        }
      } catch (e) {
        print('Exception during listening: $e');
        setState(() => _isListening = false);
        _showSnackBar('Error during speech recognition');
      }
    } else {
      _speech.stop();
      setState(() => _isListening = false);
      if (_text.isNotEmpty && _text != "start_speaking".tr() && _text != "listening".tr()) {
        _processSpeechResult();
      }
    }
  }

  void _processSpeechResult() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_text.isNotEmpty && _text != "start_speaking".tr() && _text != "listening".tr()) {
        _sendDataToServer(_text);
      }
    });
  }

  Future<void> _sendDataToServer(String text) async {
    setState(() => _isLoading = true);
    final url = Uri.parse(serverUrl);
    _showSnackBar('sending_data'.tr());

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

      print("Server response: ${response.statusCode}, ${response.body}");

      if (response.statusCode == 500) {
        throw Exception('server_error');
      }

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData.containsKey("routes")) {
          List<dynamic> list = responseData["routes"];
          List<EventRouteDTO> routes = [];
          for (var item in list) {
            Map<String, dynamic> map = item;
            routes.add(EventRouteDTO.fromMap(map));
          }

          if (mounted) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => RoutePage(routeData: routes)),
            );
          }
        } else {
          _showSnackBar('invalid_response_format'.tr());
        }
      } else {
        _showSnackBar('error_code'.tr(args: [response.statusCode.toString()]));
      }
    } catch (e) {
      print("Error sending data: $e");
      String errorMessage = e.toString().contains('server_error')
          ? 'try_again_later'.tr()
          : 'error'.tr(args: [e.toString()]);

      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("error_title".tr()),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("ok".tr()),
              ),
            ],
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _text = "start_speaking".tr();
        });
      }
    }
  }

  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showSnackBar('location_services_disabled'.tr());
      return Future.error('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showSnackBar('location_permission_denied'.tr());
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showSnackBar('location_permission_permanently_denied'.tr());
      return Future.error('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: const Duration(seconds: 10),
    );
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }
}