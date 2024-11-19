import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/video_background.dart';

class SinglePlayerScreen extends StatefulWidget {
  const SinglePlayerScreen({super.key});

  @override
  _SinglePlayerScreenState createState() => _SinglePlayerScreenState();
}

class _SinglePlayerScreenState extends State<SinglePlayerScreen> {
  List<String> board = List.generate(9, (index) => '');
  String currentPlayer = 'X';
  bool isGameOver = false;
  String result = '';

  @override
  void initState() {
    super.initState();
    if (currentPlayer == 'O') {
      _aiMove();
    }
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
        if (_isWinning(currentPlayer)) {
          isGameOver = true;
          result = "$currentPlayer Wins!";
        } else if (!board.contains('')) {
          isGameOver = true;
          result = "It's a Draw!";
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
          if (currentPlayer == 'O') {
            _aiMove();
          }
        }
      });
    }
  }

  void _aiMove() {
    int bestMove = _getBestMove();
    setState(() {
      board[bestMove] = 'O';
      if (_isWinning('O')) {
        isGameOver = true;
        result = "You Lost!";
      } else if (!board.contains('')) {
        isGameOver = true;
        result = "It's a Draw!";
      } else {
        currentPlayer = 'X';
      }
    });
  }

  int _getBestMove() {
    int bestScore = -9999;
    int move = 0;

    for (int i = 0; i < board.length; i++) {
      if (board[i].isEmpty) {
        board[i] = 'O'; // AI's move
        int score = _minimax(board, 0, false);
        board[i] = ''; // Undo move
        if (score > bestScore) {
          bestScore = score;
          move = i;
        }
      }
    }

    return move;
  }

  int _minimax(List<String> newBoard, int depth, bool isMaximizing) {
    if (_isWinning('O')) return 10 - depth;
    if (_isWinning('X')) return depth - 10;
    if (!newBoard.contains('')) return 0;

    if (isMaximizing) {
      int bestScore = -9999;
      for (int i = 0; i < newBoard.length; i++) {
        if (newBoard[i].isEmpty) {
          newBoard[i] = 'O';
          int score = _minimax(newBoard, depth + 1, false);
          newBoard[i] = '';
          bestScore = max(score, bestScore);
        }
      }
      return bestScore;
    } else {
      int bestScore = 9999;
      for (int i = 0; i < newBoard.length; i++) {
        if (newBoard[i].isEmpty) {
          newBoard[i] = 'X';
          int score = _minimax(newBoard, depth + 1, true);
          newBoard[i] = '';
          bestScore = min(score, bestScore);
        }
      }
      return bestScore;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Video background
          const VideoBackground(videoPath: 'assets/video/background2.mp4'),
          // Game UI
          Column(
            children: [
              const SizedBox(height: 40),
              Text(
                result.isNotEmpty ? result : "Player $currentPlayer's Turn",
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
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}