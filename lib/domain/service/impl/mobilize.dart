import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/cordinate.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/service/interface/mobilize.dart';

class Mobilize implements IMobilize {
  Mino moveRight(Mino mino) {
    final Cordinate cornerCordinate = mino.cornerCordinate + Cordinate(1, 0);
    final List<Block> blocks =
        mino.blocks.map<Block>((b) => Block.from(b)).toList();

    blocks.forEach((block) => block.cordinate.x += 1);

    return Mino.from(mino)
      ..blocks = blocks
      ..cornerCordinate = cornerCordinate;
  }

  Mino moveLeft(Mino mino) {
    final Cordinate cornerCordinate = mino.cornerCordinate + Cordinate(-1, 0);
    final List<Block> blocks =
        mino.blocks.map<Block>((b) => Block.from(b)).toList();

    blocks.forEach((block) => block.cordinate.x -= 1);

    return Mino.from(mino)
      ..blocks = blocks
      ..cornerCordinate = cornerCordinate;
  }

  Mino down(Mino mino) {
    final Cordinate cornerCordinate = mino.cornerCordinate + Cordinate(0, -1);
    final List<Block> blocks =
        mino.blocks.map<Block>((b) => Block.from(b)).toList();

    blocks.forEach((block) => block.cordinate.y -= 1);

    return Mino.from(mino)
      ..blocks = blocks
      ..cornerCordinate = cornerCordinate;
  }
}
