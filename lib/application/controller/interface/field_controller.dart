import 'package:re_tetris/application/usecase/operate_mino.dart';
import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/mino_administrator.dart';
import 'package:re_tetris/domain/service/interface/manage_minos.dart';

abstract class IFieldController {
  final OperateMino minoOperator;

  IManageMinos manageMinos;

  List<Block> placedBlocks;
  MinoAdministrator minoAdministrator;

  IFieldController(
    this.minoOperator,
    this.manageMinos,
    this.minoAdministrator,
    this.placedBlocks,
  );

  void hold();

  void move(MoveDirection direction);

  void rotate(RotateDirection direction);

  void onTick();

  void put();
}
