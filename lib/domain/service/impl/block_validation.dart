import 'package:re_tetris/constants.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/service/interface/block_validation.dart';

class BlockValidation implements IBlockValidation {
  bool canPutOn(Block block, List<Block> filled) => filled.any((placedBlock) {
        if (block.x >= FIELD_WIDTH) return false;
        if (block.x < 0) return false;
        if (block.y < 0) return false;

        return placedBlock.x == block.x && placedBlock.y == block.y;
      });
}
