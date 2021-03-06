import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:re_tetris/constants.dart';
import 'package:re_tetris/providers.dart';
import 'package:re_tetris/view/component/displayers/painter.dart';

class Field extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
        aspectRatio: 1 / 2,
        child: Consumer(
          builder: (_, watch, __) => CustomPaint(
            painter: Painter(
              watch(blocksState).value,
              FIELD_HEIGHT,
              GRID_SIZE,
              ignoreTopLine: true,
            ),
          ),
        ),
      ),
    );
  }
}
