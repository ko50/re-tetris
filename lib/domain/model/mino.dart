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

  Mino.from(Mino mino)
      : this.blocks = List.generate(
          mino.blocks.length,
          (i) => Block.from(mino.blocks[i]),
        ),
        this.direction = mino.direction,
        this.type = mino.type,
        this.cornerCordinate = Offset(
          mino.cornerCordinate.dx,
          mino.cornerCordinate.dy,
        );
}
