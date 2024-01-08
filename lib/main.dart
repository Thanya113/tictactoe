import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
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
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ''));

  bool isPlayerX = true; // true for 'X', false for 'O'
  bool gameOver = false;
  String winner = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.teal],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                gameOver
                    ? winner.isEmpty
                    ? 'It\'s a Draw!'
                    : '$winner is the Winner!'
                    : isPlayerX ? 'Player X\'s turn' : 'Player O\'s turn',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  return GestureDetector(
                    onTap: () {
                      if (!gameOver && board[row][col].isEmpty) {
                        setState(() {
                          board[row][col] = isPlayerX ? 'X' : 'O';
                          checkWinner(row, col);
                          isPlayerX = !isPlayerX;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          board[row][col],
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    resetGame();
                  });
                },
                child: Text('Restart Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkWinner(int row, int col) {
    // Check row
    if (board[row][0] == board[row][1] && board[row][1] == board[row][2]) {
      winner = board[row][0];
      gameOver = true;
    }
    // Check column
    else if (board[0][col] == board[1][col] && board[1][col] == board[2][col]) {
      winner = board[0][col];
      gameOver = true;
    }
    // Check diagonals
    else if ((row == col || row + col == 2) &&
        ((board[0][0] == board[1][1] && board[1][1] == board[2][2]) ||
            (board[0][2] == board[1][1] && board[1][1] == board[2][0]))) {
      winner = board[1][1];
      gameOver = true;
    }
    // Check for a draw
    else if (!board.any((row) => row.any((cell) => cell.isEmpty))) {
      winner = 'Draw';
      gameOver = true;
    }
  }

  void resetGame() {
    board = List.generate(3, (_) => List.filled(3, ''));
    isPlayerX = true;
    gameOver = false;
    winner = '';
  }
}
