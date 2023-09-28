import 'package:flutter/material.dart';
import 'dart:math';

import 'SecondPage.dart';

void main() {
  runApp(HangmanApp());
}

class HangmanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangman Game',
      home: FirstPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  static List<String> words = [
    'hangman',
    'flutter',
    'dart',
    'mobile',
    'game',
    'program',
    'developer',
    'android',
    'java',
    'kotlin',
    'swift',
    'javascript',
    'html',
    'css',
    'python',
    'computer',
    'keyboard',
    'mouse',
    'screen',
    'monitor',
    'headphone',
    'microphone',
    'camera',
    'speaker',
    'guitar',
    'piano',
    'basketball',
    'football',
    'tennis',
    'volleyball',
    'hockey',
    'soccer',
    'baseball',
  ];

  List<String> selectedWords = [];

  @override
  void initState() {
    super.initState();
    selectRandomWords();
  }

  void selectRandomWords() {
    final random = Random();
    selectedWords.clear();
    while (selectedWords.length < 3) {
      final randomWord = words[random.nextInt(words.length)];
      if (!selectedWords.contains(randomWord)) {
        selectedWords.add(randomWord);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset('assets/hangman.jpg', fit: BoxFit.cover),
          ),
          Align(
            alignment: Alignment.topCenter, // 상단 가운데 정렬
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                "Let's play HangMan!",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            top: 150,
            right: 0,
            child: Container(
              height: 300,
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '문제 선택',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      IconButton(onPressed: (){
                        setState(() {selectRandomWords();});
                      }, icon: Icon(Icons.refresh,size:35),)
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HangmanGame(selectedWords[0]),
                        ),
                      );
                    },

                    child: Text(
                      '${selectedWords[0]}',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HangmanGame(selectedWords[1]),
                        ),
                      );
                    },
                    child: Text(
                      '${selectedWords[1]}',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HangmanGame(selectedWords[2]),
                        ),
                      );
                    },
                    child: Text(
                      '${selectedWords[2]}',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
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
