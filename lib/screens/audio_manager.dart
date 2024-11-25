import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;

  final AudioPlayer _backgroundPlayer = AudioPlayer();
  bool _isMusicEnabled = true;
  bool _isSoundEnabled = true;

  AudioManager._internal();

  // Getter for the background player (if needed)
  AudioPlayer get backgroundPlayer => _backgroundPlayer;

  // Getters for public access
  bool get isMusicEnabled => _isMusicEnabled;
  bool get isSoundEnabled => _isSoundEnabled;
  double get currentVolume => _backgroundPlayer.volume;

  // Play background music
  Future<void> playBackgroundMusic(String path, double volume) async {
    if (_isMusicEnabled) {
      await _backgroundPlayer.setSourceAsset(path);
      _backgroundPlayer.setReleaseMode(ReleaseMode.loop);
      _backgroundPlayer.setVolume(volume);
      await _backgroundPlayer.resume();
    }
  }

  // Stop background music
  Future<void> stopBackgroundMusic() async {
    await _backgroundPlayer.stop();
  }

  // Toggle background music state
  void toggleMusic(bool isEnabled) {
    _isMusicEnabled = isEnabled;
    if (!_isMusicEnabled) {
      stopBackgroundMusic();
    } else {
      playBackgroundMusic('sounds/bgm.mp3', 0.5);
    }
  }

  // Toggle sound effects state
  void toggleSound(bool isEnabled) {
    _isSoundEnabled = isEnabled;
    // Additional logic for sound effects can be added here
  }

  // Set volume of the background music
  void setVolume(double volume) {
    _backgroundPlayer.setVolume(volume);
  }
}
