import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/model/mino.dart';

abstract class IRotateMino {
  Mino rotateMino(Mino mino, RotateDirection direction);
}
