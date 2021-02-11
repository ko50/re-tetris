import 'package:re_tetris/constants.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/service/interface/block_validation.dart';

class BlockValidation implements IBlockValidation {
  bool canPutBlock(Block block, List<Block> placedBlocks) {
    if (block.cordinate.x >= FIELD_WIDTH) return false;
    if (block.cordinate.x < 0) return false;
    if (block.cordinate.y < 0) return false;

    return placedBlocks
        .every((placedBlock) => placedBlock.cordinate != block.cordinate);
  }

  bool canPutMino(Mino mino, List<Block> placedBlocks) =>
      mino.blocks.every((block) => canPutBlock(block, placedBlocks));
}
