import 'package:re_tetris/domain/model/block.dart';

abstract class BlockValidation {
  bool canPutOn(Block block, List<Block> filled);
}
