import 'package:speech_to_text/speech_to_text.dart';

class VoiceService {
  final SpeechToText _speech = SpeechToText();

  Future<bool> initialize() => _speech.initialize();

  Future<String> listenOnce() async {
    if (!await initialize()) return '';
    await _speech.listen();
    await Future<void>.delayed(const Duration(seconds: 5));
    await _speech.stop();
    return _speech.lastRecognizedWords;
  }
}
