import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:re_tetris/providers.dart';
import 'package:re_tetris/view/presenter/single_play.dart';

class HoldButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 60,
      child: Material(
        type: MaterialType.card,
        color: Colors.grey[900],
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () =>
              context.read<SinglePlayPresenter>(singlePlayPresenter).hold(),
          child: Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
