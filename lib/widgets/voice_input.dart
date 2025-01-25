import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  final String serverUrl = 'https://36ec-51-20-191-32.ngrok-free.app/api/VoiceUserRequests';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
  
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
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
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': text}),
      );

      if (response.statusCode == 200) {
        print('Data sent successfully');
        _showSnackBar('Data sent successfully');
      } else {
        print('Failed to send data: ${response.statusCode}, ${response.body}');
        _showSnackBar('Error sending data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      _showSnackBar('Connection error: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}