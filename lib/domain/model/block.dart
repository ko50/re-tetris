import 'dart:ui';

class Block {
  int x;
  int y;
  final Color color;

  Block({
    required this.x,
    required this.y,
    required this.color,
  });

  Block.from(Block block)
      : this.x = block.x,
        this.y = block.y,
        this.color = Color(block.color.value);
}
