import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:re_tetris/constants.dart';

import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/view/component/mino_displayer.dart';

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
    List<List<Block>> minos =
        context.watch<ValueNotifier<List<List<Block>>>>().value;

    return Container(child: Column(children: _nextMinos(minos)));
  }
}
