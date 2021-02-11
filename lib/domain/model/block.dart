import 'dart:ui';

import 'package:re_tetris/domain/model/cordinate.dart';

class Block {
  Cordinate cordinate;
  final Color color;

  Block({
    required int x,
    required int y,
    required this.color,
  }) : this.cordinate = Cordinate(x, y);

  Block.from(Block block)
      : this.cordinate = Cordinate.from(block.cordinate),
        this.color = Color(block.color.value);
}
