import 'package:re_tetris/application/controller/interface/field_controller.dart';
import 'package:re_tetris/application/usecase/operate_mino.dart';
import 'package:re_tetris/constants.dart';
import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/cordinate.dart';
import 'package:re_tetris/domain/model/minos.dart';
import 'package:re_tetris/domain/service/interface/manage_minos.dart';

class FieldController implements IFieldController {
  final OperateMino minoOperator;

  IManageMinos manageMinos;

  List<Block> placedBlocks = [];
  Minos minosInfo;
  int lockDownMarginRemain = 15;
  int lockDownMargin = LOCKDOWN_MARGIN;

  FieldController({
    required List<TetroMino> nextMinos,
    required this.minoOperator,
    required this.manageMinos,
  }) : this.minosInfo = Minos(nextMinos: nextMinos);

  void _resetMargin() {
    lockDownMarginRemain = 15;
    lockDownMargin = LOCKDOWN_MARGIN;
  }

  void hold() {
    if (minosInfo.canHold) _resetMargin();
    minosInfo = manageMinos.holdMino(minosInfo);
  }

  void move(MoveDirection direction) {
    Cordinate before = Cordinate.from(minosInfo.operatingMino.cornerCordinate);

    minosInfo.operatingMino = minoOperator.moveMino(
      minosInfo.operatingMino,
      direction,
      placedBlocks,
    );

    Cordinate moved = Cordinate.from(minosInfo.operatingMino.cornerCordinate);

    if (moved.y < before.y)
      _resetMargin();
    else if (moved != before) {
      lockDownMargin = LOCKDOWN_MARGIN;
      lockDownMarginRemain -= 1;
    }

    if (direction == MoveDirection.Up) put();
  }

  void rotate(RotateDirection direction) {
    Cordinate before = Cordinate.from(minosInfo.operatingMino.cornerCordinate);

    minosInfo.operatingMino = minoOperator.rotateMino(
      minosInfo.operatingMino,
      direction,
      placedBlocks,
    );

    Cordinate moved = Cordinate.from(minosInfo.operatingMino.cornerCordinate);

    if (moved.y < before.y)
      _resetMargin();
    else if (moved != before) {
      lockDownMargin = LOCKDOWN_MARGIN;
      lockDownMarginRemain -= 1;
    }
  }

  void onTick(int tick) {
    lockDownMargin -= GAME_TICK;

    if (tick % DOWN_SPEED == 0) {
      Cordinate before =
          Cordinate.from(minosInfo.operatingMino.cornerCordinate);

      minosInfo.operatingMino = minoOperator.moveMino(
        minosInfo.operatingMino,
        MoveDirection.Down,
        placedBlocks,
      );

      Cordinate moved = Cordinate.from(minosInfo.operatingMino.cornerCordinate);

      if (moved.y < before.y) {
        _resetMargin();
      } else if (lockDownMargin <= 0) {
        put();
      }
    }
  }

  void put() {
    placedBlocks.addAll(minosInfo.operatingMino.blocks);
    minosInfo = manageMinos.putMino(minosInfo);
    _lineClear();
    _resetMargin();
  }

  void _lineClear() {
    int clearedLineCount = 0;
    List<int> clearableLinesY = [];
    List<Cordinate> cordinates = [];

    for (int i = 0; i <= FIELD_HEIGHT; i++) {
      cordinates = placedBlocks
          .map<Cordinate>((b) => b.cordinate)
          .where((c) => c.y == i)
          .toList();

      if (cordinates.length == FIELD_WIDTH) {
        clearableLinesY.add(i);
        clearedLineCount++;
      }
    }

    clearableLinesY.forEach((y) => placedBlocks.removeWhere(
          (block) => block.cordinate.y == y,
        ));

    if (clearedLineCount != 0) {
      placedBlocks
          .where((block) => block.cordinate.y >= clearableLinesY.last)
          .forEach((block) => block.cordinate.y -= clearedLineCount);
    }
  }
}
