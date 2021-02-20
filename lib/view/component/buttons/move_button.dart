import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/providers.dart';
import 'package:re_tetris/view/presenter/single_play.dart';

class MoveButton extends StatelessWidget {
  final MoveDirection direction;

  MoveButton(this.direction);

  static Widget united() => Container(
        width: 130,
        height: 130,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: MoveButton(MoveDirection.Left),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: MoveButton(MoveDirection.Up),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: MoveButton(MoveDirection.Right),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: MoveButton(MoveDirection.Down),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: direction.index,
      child: Container(
        height: 50,
        width: 50,
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
      ),
    );
  }
}
