import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:re_tetris/view/component/buttons/hold_button.dart';
import 'package:re_tetris/view/component/buttons/move_button.dart';
import 'package:re_tetris/view/component/buttons/rotate_button.dart';
import 'package:re_tetris/view/component/displayers/field.dart';
import 'package:re_tetris/view/component/displayers/hold.dart';
import 'package:re_tetris/view/component/displayers/next.dart';

class Play extends StatelessWidget {
  Widget _displayers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(flex: 1, child: Hold()),
        Flexible(flex: 2, child: Field()),
        Flexible(flex: 1, child: Next()),
      ],
    );
  }

  Widget _buttons() {
    return Expanded(
      child: Container(
        child: Row(
          children: [
            MoveButton.united(),
            Stack(
              children: [
                Positioned(left: 1.0, child: RotateButton.united()),
                Positioned(bottom: 1.0, right: 1.0, child: HoldButton()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProviderScope(
        child: Column(
          children: [_displayers(), _buttons()],
        ),
      ),
    );
  }
}
