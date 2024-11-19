import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Add this package for stylish fonts.

import '../widgets/video_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const VideoBackground(videoPath: 'assets/video/background2.mp4'),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title with Gradient Text
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Colors.pink, Colors.orange],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      "Tic Tac Toe",
                      style: GoogleFonts.bangers(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.8),
                            offset: const Offset(2, 2),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                // 1 Player Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/single-player');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.deepPurple,
                    shadowColor: Colors.deepPurpleAccent,
                    elevation: 8,
                  ),
                  child: Text(
                    "1 Player",
                    style: GoogleFonts.lobster(
                      fontSize: 22,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // 2 Players Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/multi-player');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.orange,
                    shadowColor: Colors.orangeAccent,
                    elevation: 8,
                  ),
                  child: Text(
                    "2 Players",
                    style: GoogleFonts.lobster(
                      fontSize: 22,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Settings Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.green,
                    shadowColor: Colors.greenAccent,
                    elevation: 8,
                  ),
                  child: Text(
                    "Settings",
                    style: GoogleFonts.lobster(
                      fontSize: 22,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
