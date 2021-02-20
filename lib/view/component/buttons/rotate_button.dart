import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/providers.dart';
import 'package:re_tetris/view/presenter/single_play.dart';

class RotateButton extends StatelessWidget {
  final RotateDirection direction;

  RotateButton(this.direction);

  static Widget united() => Container(
        width: 110,
        height: 110,
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
      height: 50,
      width: 50,
      child: Material(
        type: MaterialType.circle,
        color: Colors.grey[900],
        child: GestureDetector(
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
