import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/cordinate.dart';

class Mino {
  List<Block> blocks;
  TetroMino type;
  Direction direction = Direction.North;
  Cordinate cornerCordinate = Cordinate(3, 20);

  Mino(this.type) : this.blocks = type.initialPlacement;

  Mino.from(Mino mino)
      : this.blocks = List.generate(
          mino.blocks.length,
          (i) => Block.from(mino.blocks[i]),
        ),
        this.direction = mino.direction,
        this.type = mino.type,
        this.cornerCordinate = Cordinate(
          mino.cornerCordinate.x,
          mino.cornerCordinate.y,
        );
}
