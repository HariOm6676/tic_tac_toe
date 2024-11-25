import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/audio_manager.dart';
import 'screens/home_screen.dart';
import 'screens/multi_player_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/single_player_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final audioManager = AudioManager();

  @override
  void initState() {
    super.initState();

    // Play background music when the app starts
    audioManager.playBackgroundMusic('sounds/bgm.mp3', 0.5);

    // Listen to app lifecycle changes to stop and start music
    SystemChannels.lifecycle.setMessageHandler((message) async {
      if (message == AppLifecycleState.paused.toString()) {
        audioManager.stopBackgroundMusic();
      } else if (message == AppLifecycleState.resumed.toString()) {
        audioManager.playBackgroundMusic('sounds/bgm.mp3', 0.5);
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/single-player': (context) => const SinglePlayerScreen(),
        '/multi-player': (context) => const MultiPlayerScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
