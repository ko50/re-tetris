import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:re_tetris/application/controller/impl/field_controller.dart';
import 'package:re_tetris/domain/enum/direction.dart';

class RotateButton extends StatelessWidget {
  final RotateDirection direction;

  RotateButton(this.direction);

  static double height = 50;
  static double width = 50;

  static Widget united() => Container(
        width: 110,
        height: 110,
        child: Stack(
          children: [
            Positioned(
              top: 1.0,
              right: 1.0,
              height: 50,
              width: 50,
              child: RotateButton(RotateDirection.Right),
            ),
            Positioned(
              bottom: 1.0,
              left: 1.0,
              height: 50,
              width: 50,
              child: RotateButton(RotateDirection.Left),
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
          onTap: () => context.read<FieldController>().rotate(direction),
          onLongPress: () async {
            await Future.delayed(
              Duration(milliseconds: 100),
              () => context.read<FieldController>().rotate(direction),
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
