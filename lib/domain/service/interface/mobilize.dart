import 'package:re_tetris/domain/model/mino.dart';

abstract class IMobilize {
  Mino moveRight(Mino mino);

  Mino moveLeft(Mino mino);

  Mino down(Mino mino);
}
