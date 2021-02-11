import 'package:flutter_test/flutter_test.dart';

import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/service/impl/mobilize.dart';

void main() {
  final Mobilize mobilizeMino = Mobilize();

  late Mino mino;

  Mino movedMino;

  setUp(() {
    mino = Mino(TetroMino.T);
  });

  test('Move to right', () {
    movedMino = mobilizeMino.moveRight(mino);
    expect(
      movedMino.blocks.map<int>((b) => b.cordinate.x),
      [5, 4, 5, 6],
    );
  });

  test('Move to left', () {
    movedMino = mobilizeMino.moveLeft(mino);
    expect(
      movedMino.blocks.map<int>((b) => b.cordinate.x),
      [3, 2, 3, 4],
    );
  });

  test('Move to under', () {
    movedMino = mobilizeMino.down(mino);
    expect(
      movedMino.blocks.map<int>((b) => b.cordinate.y),
      [19, 18, 18, 18],
    );
  });
}
