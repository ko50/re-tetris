import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/service/interface/mobilize.dart';
import 'package:re_tetris/domain/service/interface/rotate.dart';

abstract class IOperateMino {
  IRotate rotate;
  IMobilize mobilize;

  IOperateMino(this.rotate, this.mobilize);

  Mino moveMino(Mino mino, MoveDirection direction);

  Mino rotateMino(Mino mino, RotateDirection direction);
}
