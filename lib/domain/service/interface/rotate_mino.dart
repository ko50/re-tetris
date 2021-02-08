import 'package:flutter/material.dart';

import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/mino.dart';

abstract class IRotateMino {
  Mino rotateMino(Mino mino, RotateDirection direction);

  List<List<int>> convertBlocks(Mino mino);

  List<Block> convertPlacement(
    List<List<int>> placement,
    Color color,
    Offset corner,
  );
}
