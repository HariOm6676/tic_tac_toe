import 'package:audioplayers/audioplayers.dart'; // Import audioplayers package
import 'package:flutter/material.dart';

import '../widgets/video_background.dart';

class MultiPlayerScreen extends StatefulWidget {
  const MultiPlayerScreen({super.key});

  @override
  _MultiPlayerScreenState createState() => _MultiPlayerScreenState();
}

class _MultiPlayerScreenState extends State<MultiPlayerScreen> {
  List<String> board = List.generate(9, (index) => '');
  String currentPlayer = 'X';
  bool isGameOver = false;
  String result = '';

  final AudioPlayer _audioPlayer = AudioPlayer(); // Audio player instance

  void _playClickSound() {
    _audioPlayer.play(AssetSource(
        'sounds/click.mp3')); // Play the click sound when a move is made
  }

  void _resetGame() {
    setState(() {
      board = List.generate(9, (index) => '');
      currentPlayer = 'X';
      isGameOver = false;
      result = '';
    });
  }

  bool _isWinning(String player) {
    // Winning combinations
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    return winPatterns.any((pattern) =>
        board[pattern[0]] == player &&
        board[pattern[1]] == player &&
        board[pattern[2]] == player);
  }

  void _handleTap(int index) {
    if (board[index].isEmpty && !isGameOver) {
      setState(() {
        board[index] = currentPlayer;
        _playClickSound(); // Play click sound when a move is made
        if (_isWinning(currentPlayer)) {
          isGameOver = true;
          result = "$currentPlayer Wins!";
        } else if (!board.contains('')) {
          isGameOver = true;
          result = "It's a Draw!";
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Set the max width for the game layout
    final maxWidth = screenWidth > 600 ? 400.0 : screenWidth * 0.8;
    final maxHeight = screenHeight > 600 ? 600.0 : screenHeight * 0.8;

    return Scaffold(
      body: Stack(
        children: [
          // Video background
          const VideoBackground(videoPath: 'assets/video/background2.mp4'),
          // Centered game UI
          Center(
            child: Container(
              width: maxWidth,
              height: maxHeight,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Game Result Text
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      result.isNotEmpty
                          ? result
                          : "Player $currentPlayer's Turn",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Game Grid
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      padding: const EdgeInsets.all(20),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _handleTap(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                board[index],
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (isGameOver)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: ElevatedButton(
                        onPressed: _resetGame,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          "Play Again",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
