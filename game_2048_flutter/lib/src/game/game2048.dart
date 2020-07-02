import 'dart:math';

import 'package:game2048/src/board/board.dart';
import 'package:game2048/src/game/game2048helper.dart';

class Game2048 {

  SquareBoard _board;

  static List<int> _colors = [
    0xffeee4da, 0xffede0c8, 0xfff2b179, 0xfff59563,
    0xfff67c5f, 0xfff65e3b, 0xffedcf72, 0xffedcc61,
    0xffedc850, 0xffedc53f, 0xffedc223
  ];

  Map<int, int> _colorMap = Map.fromIterable(
      List.generate(11, (index) => index + 1),
      key: (item) => pow(2.0, item).toInt(),
      value: (item) => _colors[item - 1]
  );

  int _emptyColor = 0xffcdc1b4;
  int _score = 0;

  Game2048() {
    starBoard();
  }

  bool canMove() => _board.any((value) => value == 0);

  int getCellValue({int i, int j}) => _board.getValue(Cell(i: i, j: j));

  int getBackgroundColor({int value}) => _colorMap[value] ?? _emptyColor;
  int getForegroundColor({int value}) => value < 16 ? 0xff776e65 : 0xfff9f6f2;

  void processMove({Direction direction}) {
    if (_move(direction: direction)) {
      _board.addNewValue();
    }
  }

  void starBoard() {
    _board = SquareBoard(width: 4);
    _board.addNewValue();
    _board.addNewValue();
    _score = 0;
  }

  bool _move({Direction direction}) {
    bool moved = false;

    for (int i = 0; i < 4; i++) {
      switch (direction) {
        case Direction.UP:
          moved = _moveValuesInRowOrColumn(rowOrColumn: _board.getColumn(i, direction)) || moved;
          break;
        case Direction.DOWN:
          moved = _moveValuesInRowOrColumn(rowOrColumn: _board.getColumn(i, direction)) || moved;
          break;
        case Direction.LEFT:
          moved = _moveValuesInRowOrColumn(rowOrColumn: _board.getRow(i, direction)) || moved;
          break;
        case Direction.RIGHT:
          moved = _moveValuesInRowOrColumn(rowOrColumn: _board.getRow(i, direction)) || moved;
          break;
      }
    }

    return moved;
  }

  bool _moveValuesInRowOrColumn({List<Cell> rowOrColumn}) {
    List<int> movedList = MergEqualOnList(rowOrColumn.map((e) => _board.getValue(e)).toList())
        .moveAndMergeEqual((value) {
          int total = value + value;
          _score += total;
          return total;
        });

    bool moved = movedList.isNotEmpty && rowOrColumn.length != movedList.length;

    for (int i = 0; i < rowOrColumn.length; i ++) {
      _board.setValue(rowOrColumn[i], i < movedList.length ? movedList[i] : 0);
    }

    return moved;
  }

  int get score => _score;

}