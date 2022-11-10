import 'dart:math';

import 'package:flutter/material.dart';

const String goo = '✊';
const String choki = '✌️';
const String per = '✋';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JankenPage(),
    );
  }
}

class JankenPage extends StatefulWidget {
  const JankenPage({Key? key}) : super(key: key);

  @override
  State<JankenPage> createState() => _JankenPageState();
}

class _JankenPageState extends State<JankenPage> {
  String myHand = goo;
  String computerHand = goo;
  String result = '引き分け';
  int roundcount = 0;
  int myselfcont = 0;
  int enemycount = 0;

  void selectHand(String selectedHand) {
    myHand = selectedHand;
    print(myHand);
    generateComputerHand();
    judge();
    fifth();
    setState(() {});
  }

  void generateComputerHand() {
    final randomNumber = Random().nextInt(3);
    computerHand = randomNumberToHand(randomNumber);
  }

  String randomNumberToHand(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return goo;
      case 1:
        return choki;
      case 2:
        return per;
      default:
        return goo;
    }
  }

  void judge() {
    // 引き分けの場合

    if (roundcount < 5) {
      if (myHand == computerHand) {
        result = '引き分け';
        roundcount += 1;
        // 勝ちの場合
      } else if (myHand == goo && computerHand == choki ||
          myHand == choki && computerHand == per ||
          myHand == per && computerHand == goo) {
        result = '勝ち';
        myselfcont += 1;
        roundcount += 1;
        // 負けの場合
      } else {
        result = '負け';
        enemycount += 1;
        roundcount += 1;
      }
    }
  }

  void fifth() {
    if (roundcount == 5) {
      if (myselfcont > enemycount) {
        result = '自分の勝ち';
        roundcount = 0;
        myselfcont = 0;
        enemycount = 0;
      } else if (myselfcont < enemycount) {
        result = '相手の勝ち';
        roundcount = 0;
        myselfcont = 0;
        enemycount = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("じゃんけん"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              result,
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(height: 48),
            Text(
              computerHand,
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            // 余白を追加
            SizedBox(height: 48),
            Text(
              myHand,
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    selectHand('✊');
                  },
                  child: Text('✊'),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectHand('✌️');
                  },
                  child: Text('✌️'),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectHand('✋');
                  },
                  child: Text('🖐'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
