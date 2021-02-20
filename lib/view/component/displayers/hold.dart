import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:re_tetris/providers.dart';
import 'package:re_tetris/view/component/displayers/mino_displayer.dart';

class Hold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, watch, __) => MinoDisplayer(watch(holdState).value),
    );
  }
}
