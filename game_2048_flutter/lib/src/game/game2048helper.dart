import 'package:game2048/src/board/board.dart';

extension MergEqualOnList on List<int> {
  List<int> moveAndMergeEqual(int add(int value)) {
    List<int> list = [];
    List<int> nonZeroList = where((e) => e > 0).toList();

    int i = 0;
    while (i < nonZeroList.length) {

      int current = nonZeroList[i];
      if (i != nonZeroList.length - 1 && current == nonZeroList[i + 1]) {
        list.add(add(current));
        i += 2;
        continue;
      }

      list.add(nonZeroList[i]);
      i++;
    }

    return list;
  }
}