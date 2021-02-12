import 'package:re_tetris/application/controller/interface/field_controller.dart';
import 'package:re_tetris/application/usecase/operate_mino.dart';
import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/model/waiting_mino_info.dart';

class FieldController implements IFieldController {
  late final OperateMino minoOperator;
  late Mino operatingMino;
  List<Block> placedBlocks = [];
  WaitingMinoInfo waitingMinoInfo = WaitingMinoInfo(
    nextMinos: List.from(TetroMino.values)..shuffle(),
  );

  FieldController({required this.minoOperator}) {}

  void hold() {}

  void move(MoveDirection direction) {}

  void rotate(RotateDirection direction) {}

  void onTick() {}

  void putMino() {}

  void _lineClear() {}
}
