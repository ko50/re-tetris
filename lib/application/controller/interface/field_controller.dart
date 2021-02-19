import 'package:re_tetris/application/usecase/operate_mino.dart';
import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/minos.dart';
import 'package:re_tetris/domain/service/interface/manage_minos.dart';

abstract class IFieldController {
  final OperateMino minoOperator;

  IManageMinos manageMinos;

  List<Block> placedBlocks;
  Minos minosInfo;
  int lockDownMargin;
  int lockDownMarginRemain;

  IFieldController(
    this.minoOperator,
    this.manageMinos,
    this.minosInfo,
    this.placedBlocks,
    this.lockDownMargin,
    this.lockDownMarginRemain,
  );

  void hold();

  void move(MoveDirection direction);

  void rotate(RotateDirection direction);

  void onTick(int tick);

  void put();
}
