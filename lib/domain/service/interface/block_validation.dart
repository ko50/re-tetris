import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/mino.dart';

abstract class IBlockValidation {
  bool canPutBlock(Block block, List<Block> placedBlocks);

  bool canPutMino(Mino mino, List<Block> placedBlocks);
}
