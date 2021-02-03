import 'package:re_tetris/domain/model/block.dart';

abstract class IBlockValidation {
  bool canPutOn(Block block, List<Block> filled);
}
