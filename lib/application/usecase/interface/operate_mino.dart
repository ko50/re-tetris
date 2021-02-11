import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/model/mino.dart';

abstract class IOperateMino {
  Mino moveMino(Mino mino, MoveDirection direction);

  Mino rotateMino(Mino mino, RotateDirection direction);
}
