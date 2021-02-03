import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/service/interface/block_validation.dart';

class BlockValidation implements IBlockValidation {
  bool canPutOn(Block block, List<Block> filled) => filled.any(
      (placedBlock) => placedBlock.x == block.x && placedBlock.y == block.y);
}
