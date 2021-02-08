import 'package:flutter/cupertino.dart';

import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/service/interface/rotate_mino.dart';

class RotateMino implements IRotateMino {
  Mino rotateMino(Mino mino, RotateDirection direction) {
    int i = direction == RotateDirection.Right ? -1 : 1;
    Mino rotatedMino = mino;

    return rotatedMino;
  }

  List<List<int>> convertBlocks(Mino mino) {
    final Size areaSize = mino.type.areaSize;
    bool sameRow, sameColumn, sameOffset;

    return List.generate(
      areaSize.height.toInt(),
      (y) => List.generate(areaSize.width.toInt(), (x) {
        sameOffset = mino.blocks.any(
          (block) {
            sameRow = mino.cornerCordinate.dy - y == block.y;
            sameColumn = mino.cornerCordinate.dx + x == block.x;
            return sameRow && sameColumn;
          },
        );

        return sameOffset ? 1 : 0;
      }),
    );
  }

  List<Block> convertPlacement(
    List<List<int>> placement,
    Color color,
    Offset corner,
  ) {
    final List<Block> blocks = [];
    placement.asMap().forEach(
          (y, row) => row.asMap().forEach((x, block) {
            if (block == 0) return;
            blocks.add(Block(
              x: (corner.dx + x).toInt(),
              y: (corner.dy - y).toInt(),
              color: color,
            ));
          }),
        );

    return blocks;
  }
}
