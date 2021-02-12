import 'package:re_tetris/application/usecase/operate_mino.dart';
import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/model/waiting_mino_info.dart';

abstract class IFieldController {
  late final OperateMino minoOperator;
  late List<Block> placedBlocks;
  late Mino operatingMino;
  late WaitingMinoInfo waitingMinoInfo;

  void hold();

  void move(MoveDirection direction);

  void rotate(RotateDirection direction);

  void onTick();

  void putMino();
}
