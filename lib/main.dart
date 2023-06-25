import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Ajay Dangoriya Tharu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  late List<List<String>> grid;
  late String currentPlayer;
  late bool gameOver;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    grid = List<List<String>>.generate(3, (_) => List<String>.filled(3, ''));
    currentPlayer = 'X';
    gameOver = false;
  }

  void makeMove(int row, int col) {
    if (grid[row][col] == '' && !gameOver) {
      setState(() {
        grid[row][col] = currentPlayer;
        checkGameStatus();
        currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
      });
    }
  }

  void checkGameStatus() {
    // Check rows
    for (int row = 0; row < 3; row++) {
      if (grid[row][0] != '' &&
          grid[row][0] == grid[row][1] &&
          grid[row][0] == grid[row][2]) {
        gameOver = true;
        break;
      }
    }

    // Check columns
    for (int col = 0; col < 3; col++) {
      if (grid[0][col] != '' &&
          grid[0][col] == grid[1][col] &&
          grid[0][col] == grid[2][col]) {
        gameOver = true;
        break;
      }
    }

    // Check diagonals
    if (grid[0][0] != '' &&
        grid[0][0] == grid[1][1] &&
        grid[0][0] == grid[2][2]) {
      gameOver = true;
    }
    if (grid[0][2] != '' &&
        grid[0][2] == grid[1][1] &&
        grid[0][2] == grid[2][0]) {
      gameOver = true;
    }

    // Check for a tie
    if (!gameOver) {
      bool isFull = true;
      for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 3; col++) {
          if (grid[row][col] == '') {
            isFull = false;
            break;
          }
        }
      }
      if (isFull) {
        gameOver = true;
      }
    }
  }

  void resetGame() {
    setState(() {
      startGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Develop By Ajay Dangoriya Tharu'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                final int row = index ~/ 3;
                final int col = index % 3;
                return GestureDetector(
                  onTap: () => makeMove(row, col),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        grid[row][col],
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              (gameOver) ? 'Game Over' : 'Current Player: $currentPlayer',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          ElevatedButton(
            onPressed: resetGame,
            child: Text('Reset Game '),
          ),
        ],
      ),
    );
  }
}
