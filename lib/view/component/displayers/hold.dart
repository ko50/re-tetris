import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:re_tetris/constants.dart';

import 'package:re_tetris/providers.dart';
import 'package:re_tetris/view/component/displayers/mino_displayer.dart';

class Hold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Consumer(
          builder: (_, watch, __) => MinoDisplayer(
            watch(holdState).value,
            GRID_SIZE * 0.9,
          ),
        ));
  }
}
