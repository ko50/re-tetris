import 'package:re_tetris/domain/model/mino.dart';

abstract class MobilizeMino {
  Mino moveRight(Mino mino);

  Mino moveLeft(Mino mino);

  Mino down(Mino mino);

  Mino hardDrop(Mino mino);
}
