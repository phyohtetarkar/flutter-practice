import 'dart:math';

class Cell {
  int _i;
  int _j;

  Cell({int i, int j}) {
    this._i = i;
    this._j = j;
  }

  int get j => _j;

  int get i => _i;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cell &&
          runtimeType == other.runtimeType &&
          _i == other._i &&
          _j == other._j;

  @override
  int get hashCode => _i.hashCode ^ _j.hashCode;

  @override
  String toString() {
    return 'Cell{_i: $_i, _j: $_j}';
  }
}

enum Direction {
  UP, DOWN, RIGHT, LEFT
}

class SquareBoard {
  int _width;

  List<List<Cell>> _cells;
  Map<Cell,int> _data;


  SquareBoard({int width}) {
    this._width = width;
    this._data = Map();
    this._cells = List.generate(width, (i) {
      return List.generate(width, (j) {
        Cell cell = Cell(i: i, j: j);

        _data[cell] = 0;

        return cell;
      });
    });

  }

  void addNewValue() {
    final List<Cell> allCells = _cells.expand((element) => element).toList();

    if (allCells.every((cell) => _data[cell] > 0)) {
      return;
    }

    allCells.shuffle();

    Cell cell = allCells.firstWhere((cell) => _data[cell] == 0, orElse: null);

    if (cell != null) {
      _data[cell] = Random().nextInt(10) == 9 ? 4 : 2;
    }
  }

  Cell getCell(int i, int j) {
    return _cells[i][j];
  }

  int getValue(Cell cell) {
    return _data[cell];
  }

  void setValue(Cell cell, int value) {
    _data[cell] = value;
  }

  List<Cell> getRow(int i, Direction direction) {
   List<Cell> row = _cells[i].toList();

   if (direction == Direction.RIGHT) {
     return row.reversed.toList();
   }

   return row;
  }

  List<Cell> getColumn(int j, Direction direction) {
    List<Cell> col = _cells.map((e) => e[j]).toList();

    if (direction == Direction.DOWN) {
      return col.reversed.toList();
    }

    return col;
  }

  bool any(bool test(int value)) {
    return _data.values.any(test);
  }

  int calculateScore() {
    Iterable<int> list = _data.values.where((v) => v > 2);
    return list.isNotEmpty ? list.reduce((value, element) => value + element) : 0;
  }

}