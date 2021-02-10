import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/service/interface/mobilize_mino.dart';

class MobilizeMino implements IMobilizeMino {
  Mino moveRight(Mino mino) {
    final List<Block> blocks =
        mino.blocks.map<Block>((b) => Block.from(b)).toList();

    blocks.forEach((block) => block.cordinate.x += 1);

    return Mino.from(mino)..blocks = blocks;
  }

  Mino moveLeft(Mino mino) {
    final List<Block> blocks =
        mino.blocks.map<Block>((b) => Block.from(b)).toList();

    blocks.forEach((block) => block.cordinate.x -= 1);

    return Mino.from(mino)..blocks = blocks;
  }

  Mino down(Mino mino) {
    final List<Block> blocks =
        mino.blocks.map<Block>((b) => Block.from(b)).toList();

    blocks.forEach((block) => block.cordinate.y -= 1);

    return Mino.from(mino)..blocks = blocks;
  }
}
