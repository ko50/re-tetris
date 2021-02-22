import 'package:flutter/cupertino.dart';

import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/cordinate.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/service/interface/rotate.dart';

class Rotate implements IRotate {
  List<List<int>> rotatePlacement(List<List<int>> placement) {
    final List<List<int>> rotatedPlacement = [];

    List<int> column;
    for (int i = 0; i < placement.length; i++) {
      column = [];
      placement.reversed.forEach((row) => column.add(row[i]));

      rotatedPlacement.add(column);
    }

    return rotatedPlacement;
  }

  Direction changeDirection(
      Direction current, RotateDirection rotateDirection) {
    final int i = rotateDirection == RotateDirection.Right ? 1 : 3;
    print(current);
    return Direction.values[(current.index + i) % 4];
  }

  List<List<int>> convertBlocks(Mino mino) {
    final Size areaSize = mino.type.areaSize;
    bool sameRow, sameColumn, sameCordinate;

    return List.generate(
      areaSize.height.toInt(),
      (y) => List.generate(
        areaSize.width.toInt(),
        (x) {
          sameCordinate = mino.blocks.any((block) {
            sameRow = mino.cornerCordinate.y - y == block.cordinate.y;
            sameColumn = mino.cornerCordinate.x + x == block.cordinate.x;
            return sameRow && sameColumn;
          });

          return sameCordinate ? 1 : 0;
        },
      ),
    );
  }

  List<Block> convertPlacement(
    List<List<int>> placement,
    Color color,
    Cordinate corner,
  ) {
    final List<Block> blocks = [];
    placement.asMap().forEach(
          (y, row) => row.asMap().forEach(
            (x, block) {
              if (block == 0) return;
              blocks.add(
                Block(
                  x: corner.x + x,
                  y: corner.y - y,
                  color: color,
                ),
              );
            },
          ),
        );

    return blocks;
  }
}
