import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/service/interface/mobilize_mino.dart';

class MobilizeMino implements IMobilizeMino {
  Mino moveRight(Mino mino) =>
      mino..blocks.map<Block>((block) => block..x += 1).toList();

  Mino moveLeft(Mino mino) =>
      mino..blocks.map<Block>((block) => block..x -= 1).toList();

  Mino down(Mino mino) =>
      mino..blocks.map<Block>((block) => block..y -= 1).toList();
}
