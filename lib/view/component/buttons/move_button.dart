import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/providers.dart';
import 'package:re_tetris/view/presenter/single_play.dart';

class MoveButton extends StatefulWidget {
  final MoveDirection direction;

  MoveButton(this.direction);

  static Widget united() => Container(
        width: 180,
        height: 180,
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
  _MoveButtonState createState() => _MoveButtonState();
}

class _MoveButtonState extends State<MoveButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: widget.direction.index,
      child: Container(
        height: 70,
        width: 70,
        child: Material(
          type: MaterialType.circle,
          color: Colors.grey[900],
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => context
                .read<SinglePlayPresenter>(singlePlayPresenter)
                .move(widget.direction),
            onLongPress: () async {
              while (_pressed && widget.direction != MoveDirection.Up)
                await Future.delayed(
                  Duration(milliseconds: 150),
                  () => context
                      .read<SinglePlayPresenter>(singlePlayPresenter)
                      .move(widget.direction),
                );
            },
            onLongPressStart: (_) => _pressed = true,
            onLongPressEnd: (_) => _pressed = false,
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
