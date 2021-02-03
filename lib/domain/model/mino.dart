import 'package:flutter/cupertino.dart';

import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/block.dart';

class Mino {
  List<Block> blocks;
  TetroMino type;
  Direction direction;
  Offset cornerCordinate = Offset(3, 20);

  Mino({
    required this.blocks,
    required this.type,
    required this.direction,
  });
}
