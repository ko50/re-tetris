import 'package:flutter/material.dart';

import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/view/component/displayers/painter.dart';

class MinoDisplayer extends StatelessWidget {
  final List<Block> blocks;
  final double blockSize;

  MinoDisplayer(this.blocks, this.blockSize);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        height: blockSize * 2,
        width: blockSize * 3,
        padding: EdgeInsets.all(blockSize * 0.8),
        color: Colors.black,
        child: CustomPaint(
          painter: Painter(blocks, 3, blockSize),
        ),
      ),
    );
  }
}
