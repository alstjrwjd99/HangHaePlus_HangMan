import 'package:flutter/material.dart';

import 'package:hangmangame/main.dart';

class HangmanGame extends StatefulWidget {
  final String selectedWord;

  HangmanGame(this.selectedWord);

  @override
  _HangmanGameState createState() => _HangmanGameState();
}

class _HangmanGameState extends State<HangmanGame> {
  String currentWord = '';
  Set<String> guessedLetters = Set();
  int attemptsLeft = 8;
  int currentWordIndex = 0;
  bool isGameover = false;

  @override
  void initState() {
    super.initState();
    selectRandomWord();
  }

  void selectRandomWord() {
    currentWord = '_ ' * widget.selectedWord.length;
    guessedLetters.clear();
    attemptsLeft = 8;
  }

  void makeGuess(String letter) {
    setState(() {
      guessedLetters.add(letter);

      if (!widget.selectedWord.contains(letter)) {
        attemptsLeft--;
      } else {
        // Update the current word with the guessed letter(s)
        final word = widget.selectedWord;
        final newWord = StringBuffer();
        for (var i = 0; i < word.length; i++) {
          if (guessedLetters.contains(word[i])) {
            newWord.write(word[i]);
          } else {
            newWord.write('_ ');
          }
        }
        currentWord = newWord.toString();
      }
    });
    GameOver();
  }

  void GameOver (){
    if (attemptsLeft <= 0 || currentWord == widget.selectedWord) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('게임 종료'),
            content: Text('정답 : ${widget.selectedWord}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => FirstPage()),
                        (Route<dynamic> route) =>
                    false, // Remove all routes from stack
                  );
                },
                child: Text(
                  '다른 문제 풀기',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hangman Game'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Attempts Left: $attemptsLeft',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            CustomPaint(
              size: Size(200, 200),
              painter: HangmanPainter(attemptsLeft: attemptsLeft),
            ),
            SizedBox(height: 20),
            Text(
              'Word: $currentWord',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Container(
              height: 300,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6, // Number of columns
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                ),
                itemCount: 26,
                itemBuilder: (BuildContext context, int index) {
                  final letter = String.fromCharCode('a'.codeUnitAt(0) + index);
                  return Padding(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () {
                        GameOver();
                        if (!guessedLetters.contains(letter)) {
                          makeGuess(letter);
                        }
                      },
                      child: Text(
                        letter,
                        style: TextStyle(fontSize: 30),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: guessedLetters.contains(letter)
                            ? Colors.red
                            : Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HangmanPainter extends CustomPainter {
  final int attemptsLeft;

  HangmanPainter({required this.attemptsLeft});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    if (attemptsLeft < 8) {
      // Draw the gallows
      canvas.drawLine(
          Offset(20, size.height - 20), Offset(100, size.height - 20), paint);
      canvas.drawLine(Offset(60, size.height - 20), Offset(60, 20), paint);
      canvas.drawLine(Offset(100, 20), Offset(60, 20), paint);
      canvas.drawLine(Offset(100, 20), Offset(100, 40), paint);
    }

    if (attemptsLeft < 7) {
      // Draw the head
      canvas.drawCircle(Offset(100, 60), 20, paint);
    }

    if (attemptsLeft < 6) {
      // Draw the body
      canvas.drawLine(Offset(100, 80), Offset(100, 120), paint);
    }

    if (attemptsLeft < 5) {
      // Draw the left arm
      canvas.drawLine(Offset(100, 90), Offset(80, 120), paint);
    }

    if (attemptsLeft < 4) {
      // Draw the right arm
      canvas.drawLine(Offset(100, 90), Offset(120, 120), paint);
    }

    if (attemptsLeft < 3) {
      // Draw the left leg
      canvas.drawLine(Offset(100, 120), Offset(80, 160), paint);
    }

    if (attemptsLeft < 2) {
      // Draw the right leg
      canvas.drawLine(Offset(100, 120), Offset(120, 160), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
