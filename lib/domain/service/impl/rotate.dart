import 'package:flutter/cupertino.dart';

import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/service/interface/rotate.dart';

class Rotate implements IRotate {
  List<List<int>> rotate(List<List<int>> placement, RotateDirection direction) {
    /*
    (Mino mino, RotateDirection direction) {
    final Mino rotatedMino = Mino.from(mino);
    final List<List<int>> placement = direction == RotateDirection.Left
        ? convertBlocks(mino)
        : convertBlocks(mino).reversed.toList();
  */
    final List<List<int>> rotatedPlacement = [];

    List<int> column;
    for (int i = 0; i < placement.length; i++) {
      column = [];
      placement.forEach((row) => column.add(row[i]));

      rotatedPlacement.add(column);
    }

    return rotatedPlacement;
    /*
      rotatedMino
        ..direction = _changeDirection(mino.direction, direction)
        ..blocks = convertPlacement(
          rotatedPlacement,
          mino.type.color,
          mino.cornerCordinate,
      );
    */
  }

  Direction changeDirection(
      Direction current, RotateDirection rotateDirection) {
    final int i = rotateDirection == RotateDirection.Right ? 1 : -1;
    return Direction.values[(current.index + i) % 4];
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
