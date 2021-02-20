import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/providers.dart';
import 'package:re_tetris/view/presenter/single_play.dart';

class MoveButton extends StatelessWidget {
  final MoveDirection direction;

  MoveButton(this.direction);

  static double height = 50;
  static double width = 50;

  static Widget united() => Container(
        width: 110,
        height: 110,
        child: Stack(
          children: [
            Positioned(
              left: 1.0,
              height: 50,
              width: 50,
              child: MoveButton(MoveDirection.Left),
            ),
            Positioned(
              top: 1.0,
              height: 50,
              width: 50,
              child: MoveButton(MoveDirection.Up),
            ),
            Positioned(
              right: 1.0,
              height: 50,
              width: 50,
              child: MoveButton(MoveDirection.Right),
            ),
            Positioned(
              bottom: 1.0,
              height: 50,
              width: 50,
              child: MoveButton(MoveDirection.Down),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: direction.index,
      child: Material(
        type: MaterialType.circle,
        color: Colors.grey[900],
        child: GestureDetector(
          onTap: () => context
              .read<SinglePlayPresenter>(singlePlayPresenter)
              .move(direction),
          onLongPress: () async {
            await Future.delayed(
              Duration(milliseconds: 100),
              () => context
                  .read<SinglePlayPresenter>(singlePlayPresenter)
                  .move(direction),
            );
          },
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
