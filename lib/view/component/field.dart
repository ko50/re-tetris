import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/view/component/painter.dart';

class Field extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 2,
      child: CustomPaint(painter: Painter(context.read<List<Block>>())),
    );
  }
}
