import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/view/component/painter.dart';

class Hold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Block> blocks = context.watch<ValueNotifier<List<Block>>>().value;

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
