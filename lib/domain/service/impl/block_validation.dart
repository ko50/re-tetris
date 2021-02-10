import 'package:re_tetris/constants.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/service/interface/block_validation.dart';

class BlockValidation implements IBlockValidation {
  bool canPutOn(Block block, List<Block> filled) => filled.any((placedBlock) {
        if (block.cordinate.x >= FIELD_WIDTH) return false;
        if (block.cordinate.x < 0) return false;
        if (block.cordinate.y < 0) return false;

        return placedBlock.cordinate == block.cordinate;
      });
}
