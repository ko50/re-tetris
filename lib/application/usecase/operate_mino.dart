import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/enum/rotate_pattern.dart';
import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/cordinate.dart';
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

    return validator.canPutMino(mino, placedBlocks) ? movedMino : mino;
  }

  Mino _hardDrop(Mino mino, List<Block> placedBlocks) {
    Mino actualMovedMino = Mino.from(mino), tmpMovedMino = mobilize.down(mino);

    while (validator.canPutMino(tmpMovedMino, placedBlocks)) {
      actualMovedMino = Mino.from(tmpMovedMino);
      mobilize.down(tmpMovedMino);
    }

    return actualMovedMino;
  }

  Mino rotateMino(
      Mino mino, RotateDirection direction, List<Block> placedBlocks) {
    List<Block> blocks = rotate.convertPlacement(
      rotate.rotate(rotate.convertBlocks(mino), direction),
      mino.type.color,
      mino.cornerCordinate,
    );

    Mino rotatedMino = Mino.from(mino)
      ..blocks = blocks
      ..direction = rotate.changeDirection(mino.direction, direction);

    mino.direction
        .rotatePattern(direction)
        .srsShiftCandidates(mino.type)
        .forEach((shift) {
      if (validator.canPutMino(rotatedMino, placedBlocks)) return;

      rotatedMino.blocks.forEach((block) => block.cordinate += shift);
    });

    return rotatedMino;
  }
}
