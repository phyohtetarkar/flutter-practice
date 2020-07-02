import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:game2048/src/board/board.dart';
import 'package:game2048/src/game/game2048.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

void main() {
  runApp(Game2048App());
}

class Game2048App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xfffaf8f0),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Game2048Screen(),
          ),
        ),
      ),
    );
  }
}

class Game2048Screen extends StatefulWidget {
  @override
  _Game2048ScreenState createState() => _Game2048ScreenState();
}

class _Game2048ScreenState extends State<Game2048Screen> {
  Game2048 _game2048 = Game2048();

  void _onSwipe(SwipeDirection direction) {
    //if (!_game2048.canMove()) return;
    setState(() {
      switch (direction) {
        case SwipeDirection.left:
          _game2048.processMove(direction: Direction.LEFT);
          break;
        case SwipeDirection.right:
          _game2048.processMove(direction: Direction.RIGHT);
          break;
        case SwipeDirection.down:
          _game2048.processMove(direction: Direction.DOWN);
          break;
        case SwipeDirection.up:
          _game2048.processMove(direction: Direction.UP);
          break;
      }
    });
  }

  Card createCell({int i, int j}) {
    int value = _game2048.getCellValue(i: i, j: j);
    return Card(
      elevation: 0,
      color: Color(_game2048.getBackgroundColor(value: value)),
      child: Center(
        child: AutoSizeText(
          value > 0 ? '$value' : '',
          maxLines: 1,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Color(_game2048.getForegroundColor(value: value))),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                '2048',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 72,
                  color: Color(0xff776e65),
                ),
              ),
            ),
            Container(
              child: Card(
                margin: EdgeInsets.all(0),
                color: Color(0xffbbada0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'SCORE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        '${_game2048.score}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Play 2048 Game',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xff776e65),
                ),
              ),
            ),
            FlatButton(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              color: Colors.brown,
              onPressed: () {
                setState(() {
                  _game2048.starBoard();
                });
              },
              child: Text(
                'New Game',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            )
          ],
        ),
        SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 1 / 1,
          child: SimpleGestureDetector(
            onVerticalSwipe: _onSwipe,
            onHorizontalSwipe: _onSwipe,
            swipeConfig: SimpleSwipeConfig(
              verticalThreshold: 40.0,
              horizontalThreshold: 40.0,
              swipeDetectionBehavior: SwipeDetectionBehavior.singularOnEnd
            ),
            child: Card(
              margin: EdgeInsets.all(0),
              color: Color(0xffbbada0),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (i) {
                    return Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: List.generate(4, (j) {
                          return Expanded(
                            child: createCell(i: i, j: j),
                          );
                        }),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 50),
        Row(
          children: <Widget>[
            Card(
              color: Colors.blue,
            )
          ],
        ),
      ],
    );
  }
}
