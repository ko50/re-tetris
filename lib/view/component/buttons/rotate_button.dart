import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/providers.dart';
import 'package:re_tetris/view/presenter/single_play.dart';

class RotateButton extends StatelessWidget {
  final RotateDirection direction;

  RotateButton(this.direction);

  static Widget united() => Container(
        width: 150,
        height: 150,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: RotateButton(RotateDirection.Right),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: RotateButton(RotateDirection.Left),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      child: Material(
        type: MaterialType.circle,
        color: Colors.grey[900],
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => context
              .read<SinglePlayPresenter>(singlePlayPresenter)
              .rotate(direction),
          onLongPress: () async {
            await Future.delayed(
              Duration(milliseconds: 100),
              () => context
                  .read<SinglePlayPresenter>(singlePlayPresenter)
                  .rotate(direction),
            );
          },
          child: Icon(
            direction == RotateDirection.Right
                ? Icons.rotate_right
                : Icons.rotate_left,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
