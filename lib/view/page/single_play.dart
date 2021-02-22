import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:re_tetris/view/component/buttons/hold_button.dart';
import 'package:re_tetris/view/component/buttons/move_button.dart';
import 'package:re_tetris/view/component/buttons/rotate_button.dart';
import 'package:re_tetris/view/component/displayers/field.dart';
import 'package:re_tetris/view/component/displayers/hold.dart';
import 'package:re_tetris/view/component/displayers/next.dart';

class SinglePlay extends StatelessWidget {
  Widget _displayers() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(flex: 1, child: Hold()),
            Flexible(flex: 2, child: Field()),
            Flexible(flex: 1, child: Next()),
          ],
        ));
  }

  Widget _buttons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MoveButton.united(),
          SizedBox(width: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              RotateButton.united(),
              Positioned(right: 0.0, bottom: 0.0, child: HoldButton()),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Single play')),
      body: ProviderScope(
        child: Column(
          children: [
            _displayers(),
            _buttons(),
          ],
        ),
      ),
    );
  }
}
