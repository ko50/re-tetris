import 'package:flutter/material.dart';

import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/cordinate.dart';
import 'package:re_tetris/domain/model/mino.dart';

abstract class IRotate {
  List<List<int>> rotatePlacement(List<List<int>> placement);

  Direction changeDirection(Direction current, RotateDirection direction);

  List<List<int>> convertBlocks(Mino mino);

  List<Block> convertPlacement(
    List<List<int>> placement,
    Color color,
    Cordinate corner,
  );
}
