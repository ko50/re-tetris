import 'package:flutter/foundation.dart';
import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/enum/rotate_pattern.dart';
import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/service/interface/block_validation.dart';
import 'package:re_tetris/domain/service/interface/mobilize.dart';
import 'package:re_tetris/domain/service/interface/rotate.dart';

class OperateMino {
  IRotate rotate;
  IMobilize mobilize;
  IBlockValidation validator;

  OperateMino(this.rotate, this.mobilize, this.validator);

  Mino moveMino(Mino mino, MoveDirection direction, List<Block> placedBlocks) {
    Mino movedMino;

    switch (direction) {
      case MoveDirection.Right:
        movedMino = mobilize.moveRight(mino);
        break;

      case MoveDirection.Left:
        movedMino = mobilize.moveLeft(mino);
        break;

      case MoveDirection.Down:
        movedMino = mobilize.down(mino);
        break;

      case MoveDirection.Up:
        movedMino = _hardDrop(mino, placedBlocks);
        break;
    }

    return validator.canPutMino(movedMino, placedBlocks) ? movedMino : mino;
  }

  Mino _hardDrop(Mino mino, List<Block> placedBlocks) {
    Mino actualMovedMino = Mino.from(mino), tmpMovedMino = mobilize.down(mino);

    while (validator.canPutMino(tmpMovedMino, placedBlocks)) {
      if (validator.canPutMino(tmpMovedMino, placedBlocks))
        actualMovedMino = Mino.from(tmpMovedMino);

      tmpMovedMino = mobilize.down(tmpMovedMino);
    }

    return actualMovedMino;
  }

  Mino rotateMino(
      Mino mino, RotateDirection direction, List<Block> placedBlocks) {
    final List<List<int>> placement = rotate.convertBlocks(mino);

    List<List<int>> rotatedPlacement =
        List.from(placement.map<List<int>>((row) => List.from(row)));

    for (int i = 0; i < 3; i++) {
      rotatedPlacement = rotate.rotatePlacement(rotatedPlacement);
      if (direction == RotateDirection.Right) break;
    }

    List<Block> blocks = rotate.convertPlacement(
      rotatedPlacement,
      mino.type.color,
      mino.cornerCordinate,
    );

    Mino rotatedMino = Mino.from(mino)
      ..blocks = blocks.map<Block>((b) => Block.from(b)).toList();

    Mino? srsAppliedMino = _applySrs(rotatedMino, direction, placedBlocks);

    rotatedMino.blocks.forEach((element) => print(element.cordinate));

    if (srsAppliedMino != null)
      return srsAppliedMino
        ..direction = rotate.changeDirection(mino.direction, direction);

    return mino;
  }

  Mino? _applySrs(
      Mino mino, RotateDirection direction, List<Block> placedBlocks) {
    Mino applied = Mino.from(mino);
    bool rotationSucceed = false;

    mino.direction
        .rotatePattern(direction)
        .srsShiftCandidates(mino.type)
        .forEach((shift) {
      if (validator.canPutMino(applied, placedBlocks)) {
        rotationSucceed = true;
        return;
      }

      mino.blocks.asMap().forEach(
          (i, b) => applied.blocks[i] = Block.from(b)..cordinate += shift);
    });

    print('Rotate ${mino.type}: $rotationSucceed');

    // If failed to rotate, returns null
    return rotationSucceed ? applied : null;
  }
}
