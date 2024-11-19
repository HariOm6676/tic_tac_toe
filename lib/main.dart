import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/single_player_screen.dart';
import 'screens/multi_player_screen.dart';
import 'screens/settings_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
