import 'package:re_tetris/application/controller/interface/field_controller.dart';
import 'package:re_tetris/application/usecase/operate_mino.dart';
import 'package:re_tetris/constants.dart';
import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/cordinate.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/model/mino_administrator.dart';
import 'package:re_tetris/domain/service/interface/manage_minos.dart';

class FieldController implements IFieldController {
  final OperateMino minoOperator;

  IManageMinos manageMinos;

  List<Block> placedBlocks = [];
  MinoAdministrator minoAdministrator;
  int lockDownMarginRemain = 15;
  int lockDownMargin = 500;

  FieldController({
    required List<TetroMino> nextMinos,
    required this.minoOperator,
    required this.manageMinos,
  }) : this.minoAdministrator = MinoAdministrator(nextMinos: nextMinos);

  void _resetMargin() {
    lockDownMarginRemain = 15;
    lockDownMargin = 500;
  }

  void hold() {
    minoAdministrator = manageMinos.holdMino(minoAdministrator);
    _resetMargin();
  }

  void move(MoveDirection direction) {
    Cordinate before =
        Cordinate.from(minoAdministrator.operatingMino.cornerCordinate);

    minoAdministrator.operatingMino = minoOperator.moveMino(
      minoAdministrator.operatingMino,
      direction,
      placedBlocks,
    );

    Cordinate moved =
        Cordinate.from(minoAdministrator.operatingMino.cornerCordinate);

    if (moved.y < before.y)
      _resetMargin();
    else if (moved != before) {
      lockDownMargin = 500;
      lockDownMarginRemain -= 1;
    }

    if (direction == MoveDirection.Up) put();
  }

  void rotate(RotateDirection direction) {
    Cordinate before =
        Cordinate.from(minoAdministrator.operatingMino.cornerCordinate);

    minoAdministrator.operatingMino = minoOperator.rotateMino(
      minoAdministrator.operatingMino,
      direction,
      placedBlocks,
    );

    Cordinate moved =
        Cordinate.from(minoAdministrator.operatingMino.cornerCordinate);

    if (moved.y < before.y)
      _resetMargin();
    else if (moved != before) {
      lockDownMargin = 500;
      lockDownMarginRemain -= 1;
    }
  }

  void onTick() {
    lockDownMargin -= GAME_TICK;

    Cordinate before =
        Cordinate.from(minoAdministrator.operatingMino.cornerCordinate);

    minoAdministrator.operatingMino = minoOperator.moveMino(
      minoAdministrator.operatingMino,
      MoveDirection.Down,
      placedBlocks,
    );

    Cordinate moved =
        Cordinate.from(minoAdministrator.operatingMino.cornerCordinate);

    if (moved.y < before.y)
      _resetMargin();
    else if (lockDownMargin <= 0) put();
  }

  void put() {
    minoAdministrator = manageMinos.putMino(minoAdministrator);
    _lineClear();
    _resetMargin();
  }

  void _lineClear() {}
}
