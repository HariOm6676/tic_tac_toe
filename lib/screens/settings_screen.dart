import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../widgets/video_background.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSoundEnabled = true;
  bool isBackgroundMusicEnabled = true;
  double soundVolume = 0.5;
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Background music file
  final String backgroundMusic = 'assets/sounds/bgm.mp3';
  // Sound effect file
  final String clickSound = 'assets/sounds/click.mp3';

  @override
  void initState() {
    super.initState();
    _playBackgroundMusic();
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playBackgroundMusic() {
    if (isBackgroundMusicEnabled) {
      _audioPlayer.setVolume(soundVolume);
      _audioPlayer.setReleaseMode(ReleaseMode.loop);
      _audioPlayer.play(AssetSource(backgroundMusic));
    } else {
      _audioPlayer.stop();
    }
  }

  void _playClickSound() {
    if (isSoundEnabled) {
      final player = AudioPlayer();
      player.setVolume(soundVolume);
      player.play(AssetSource(clickSound));
    }
  }

  void _toggleSound() {
    setState(() {
      isSoundEnabled = !isSoundEnabled;
    });
    _playClickSound();
  }

  void _toggleBackgroundMusic() {
    setState(() {
      isBackgroundMusicEnabled = !isBackgroundMusicEnabled;
    });
    _playBackgroundMusic();
  }

  void _changeVolume(double value) {
    setState(() {
      soundVolume = value;
    });
    _audioPlayer.setVolume(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Video Background
          const VideoBackground(videoPath: 'assets/video/background2.mp4'),
          // Settings UI
          Column(
            children: [
              // Curved Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    const SizedBox(height: 30),
                    // Sound Toggle
                    SwitchListTile(
                      value: isSoundEnabled,
                      onChanged: (value) {
                        _toggleSound();
                      },
                      title: const Text(
                        "Enable Sound Effects",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      activeColor: Colors.purple,
                      inactiveThumbColor: Colors.grey,
                    ),
                    const SizedBox(height: 10),
                    // Background Music Toggle
                    SwitchListTile(
                      value: isBackgroundMusicEnabled,
                      onChanged: (value) {
                        _toggleBackgroundMusic();
                      },
                      title: const Text(
                        "Enable Background Music",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      activeColor: Colors.purple,
                      inactiveThumbColor: Colors.grey,
                    ),
                    const SizedBox(height: 10),
                    // Sound Volume Slider
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sound Volume",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Slider(
                          value: soundVolume,
                          onChanged: (value) => _changeVolume(value),
                          min: 0,
                          max: 1,
                          divisions: 10,
                          activeColor: Colors.purple,
                          inactiveColor: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Developer Info Button
                    ElevatedButton(
                      onPressed: () {
                        _playClickSound();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Developer Info"),
                              content: const Text(
                                "Tic Tac Toe Game\nVersion: 1.0\nDeveloped by: [Your Name]",
                                style: TextStyle(fontSize: 16),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Close"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Developer Info",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Back Button
                    ElevatedButton(
                      onPressed: () {
                        _playClickSound();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Back to Home",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
