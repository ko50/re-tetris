import 'package:flutter/cupertino.dart';

import 'package:re_tetris/domain/model/block.dart';

class Painter extends CustomPainter {
  List<Block> blocks;
  int height;
  double blockSize;
  bool ignoreTopLine;

  Painter(
    this.blocks,
    this.height,
    this.blockSize, {
    this.ignoreTopLine = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint;

    for (Block block in blocks) {
      paint = Paint()
        ..style = PaintingStyle.fill
        ..color = block.color;

      canvas.drawRect(
        Rect.fromLTWH(
          blockSize * block.cordinate.x,
          blockSize *
              ((block.cordinate.y - height).abs() - (ignoreTopLine ? 1 : 0)),
          blockSize,
          blockSize,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(Painter old) => true;
}
