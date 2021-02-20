import 'package:flutter/cupertino.dart';
import 'package:re_tetris/constants.dart';
import 'package:re_tetris/domain/model/block.dart';

class Painter extends CustomPainter {
  List<Block> blocks;

  Painter(this.blocks);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint;

    for (Block block in blocks) {
      paint = Paint()
        ..style = PaintingStyle.fill
        ..color = block.color;

      canvas.drawRect(
        Rect.fromLTWH(
          GRID_SIZE * block.cordinate.x,
          GRID_SIZE * block.cordinate.y,
          GRID_SIZE,
          GRID_SIZE,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(Painter old) => true;
}
