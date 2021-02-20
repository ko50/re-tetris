import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:re_tetris/constants.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/providers.dart';
import 'package:re_tetris/view/component/displayers/mino_displayer.dart';

class Next extends StatelessWidget {
  List<Widget> _nextMinos(List<List<Block>> minos) {
    List<Widget> widgets = [];

    widgets.add(MinoDisplayer(minos.first));
    widgets.addAll(minos
        .sublist(1)
        .map<Widget>((blocks) => Padding(
            padding: EdgeInsets.only(left: GRID_SIZE, top: GRID_SIZE / 2),
            child: MinoDisplayer(blocks)))
        .toList());

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Consumer(
      builder: (_, watch, __) => Column(
        children: _nextMinos(watch(nextState).value),
      ),
    ));
  }
}
