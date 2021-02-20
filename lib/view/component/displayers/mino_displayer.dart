import 'package:flutter/material.dart';

import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/view/component/displayers/painter.dart';

class MinoDisplayer extends StatelessWidget {
  final List<Block> blocks;

  MinoDisplayer(this.blocks);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: Container(
        color: Colors.black,
        child: Center(
          child: CustomPaint(
            painter: Painter(blocks),
          ),
        ),
      ),
    );
  }
}
