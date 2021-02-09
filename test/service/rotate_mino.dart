import 'package:test/test.dart';

import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/service/impl/rotate.dart';

void main() {
  final rotateMino = Rotate();
  final mino = Mino(TetroMino.T);

  test(
    'convertion blocks to mino placement',
    () {},
  );
}
