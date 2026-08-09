import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vosk_flutter/vosk_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final VoskFlutterPlugin _vosk = VoskFlutterPlugin.instance();
  Model? _model;
  Recognizer? _recognizer;
  SpeechService? _speechService;
  
  bool _isListening = false;
  String _recognizedText = "Tap the button and speak your emergency message...";

  @override
  void initState() {
    super.initState();
    _initVosk();
  }

  Future<void> _initVosk() async {
    // Load the offline model asset
    final modelPath = await ModelLoader().loadFromAssets('assets/models/vosk-model-small-en-us-0.15');
    _model = await _vosk.createModel(modelPath);
    _recognizer = await _vosk.createRecognizer(
      model: _model!,
      sampleRate: 16000,
    );
    _speechService = await _vosk.initSpeechService(_recognizer!);
  }

  void _toggleListening() async {
    if (_speechService == null) return;

    if (_isListening) {
      await _speechService!.stop();
      setState(() => _isListening = false);
      _saveTicketToHive(_recognizedText);
    } else {
      setState(() {
        _isListening = true;
        _recognizedText = "Listening...";
      });

      _speechService!.onPartial().listen((partial) {
        // Updated partial text handling
      });

      _speechService!.onResult().listen((result) {
        setState(() {
          _recognizedText = result;
        });
      });

      await _speechService!.start();
    }
  }

  void _saveTicketToHive(String message) {
    final box = Hive.box('rescue_tickets');
    box.add({
      'raw_text': message,
      'timestamp': DateTime.now().toIso8601String(),
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Rescue Ticket saved offline to Hive DB!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RescueLink - Voice Report")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _recognizedText,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                backgroundColor: _isListening ? Colors.red : Colors.green,
              ),
              onPressed: _toggleListening,
              icon: Icon(_isListening ? Icons.stop : Icons.mic, color: Colors.white),
              label: Text(
                _isListening ? "Stop & Save" : "Start Speaking",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}