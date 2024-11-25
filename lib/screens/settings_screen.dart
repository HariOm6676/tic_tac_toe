import 'package:flutter/material.dart';

import '../screens/audio_manager.dart';
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

  final AudioManager audioManager = AudioManager();

  @override
  void initState() {
    super.initState();
    isBackgroundMusicEnabled = audioManager.isMusicEnabled;
    soundVolume = audioManager.currentVolume;
    if (isBackgroundMusicEnabled) {
      audioManager.playBackgroundMusic('sounds/bgm.mp3', soundVolume);
    }
  }

  void _toggleSound() {
    setState(() {
      isSoundEnabled = !isSoundEnabled;
    });
    audioManager.toggleSound(isSoundEnabled);
  }

  void _toggleBackgroundMusic() {
    setState(() {
      isBackgroundMusicEnabled = !isBackgroundMusicEnabled;
    });
    audioManager.toggleMusic(isBackgroundMusicEnabled);
    if (isBackgroundMusicEnabled) {
      audioManager.playBackgroundMusic('sounds/bgm.mp3', soundVolume);
    } else {
      audioManager.stopBackgroundMusic();
    }
  }

  void _changeVolume(double value) {
    setState(() {
      soundVolume = value;
    });
    audioManager.setVolume(value);
  }

  @override
  void dispose() {
    // audioManager
    // .stopBackgroundMusic(); // Stop background music when the screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const VideoBackground(videoPath: 'assets/video/background2.mp4'),
          Column(
            children: [
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
                    ElevatedButton(
                      onPressed: () {
                        // Add click sound logic here if needed
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Developer Info"),
                              content: const Text(
                                "Tic Tac Toe Game\nVersion: 1.0\nDeveloped by: Professor Hari Om Shukla",
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
                    ElevatedButton(
                      onPressed: () {
                        // Add click sound logic here if needed
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
