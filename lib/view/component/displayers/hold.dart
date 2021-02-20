import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/view/component/displayers/mino_displayer.dart';

class Hold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Block> blocks = context.watch<ValueNotifier<List<Block>>>().value;

    return MinoDisplayer(blocks);
  }
}
