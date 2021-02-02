import 'package:flutter/material.dart';

import 'package:re_tetris/domain/model/block.dart';

enum TetroMino { T, S, Z, L, J, O, I }

extension Info on TetroMino {
  Color get color {
    switch (this) {
      case TetroMino.T:
        return Colors.purple;
      case TetroMino.S:
        return Colors.green;
      case TetroMino.Z:
        return Colors.red;
      case TetroMino.L:
        return Colors.orange;
      case TetroMino.J:
        return Colors.blue;
      case TetroMino.O:
        return Colors.yellow;
      case TetroMino.I:
        return Colors.cyan;
    }
  }

  List<Block> get initialPlacement {
    switch (this) {
      case TetroMino.T:
        return [
          Block(x: 4, y: 20, color: this.color),
          Block(x: 3, y: 19, color: this.color),
          Block(x: 3, y: 19, color: this.color),
          Block(x: 3, y: 19, color: this.color),
        ];
      case TetroMino.S:
        return [
          Block(x: 4, y: 20, color: this.color),
          Block(x: 5, y: 20, color: this.color),
          Block(x: 3, y: 19, color: this.color),
          Block(x: 4, y: 19, color: this.color),
        ];
      case TetroMino.Z:
        return [
          Block(x: 3, y: 20, color: this.color),
          Block(x: 4, y: 20, color: this.color),
          Block(x: 4, y: 19, color: this.color),
          Block(x: 5, y: 19, color: this.color),
        ];
      case TetroMino.L:
        return [
          Block(x: 5, y: 20, color: this.color),
          Block(x: 3, y: 19, color: this.color),
          Block(x: 4, y: 19, color: this.color),
          Block(x: 5, y: 19, color: this.color),
        ];
      case TetroMino.J:
        return [
          Block(x: 3, y: 20, color: this.color),
          Block(x: 3, y: 19, color: this.color),
          Block(x: 4, y: 19, color: this.color),
          Block(x: 5, y: 19, color: this.color),
        ];
      case TetroMino.O:
        return [
          Block(x: 4, y: 20, color: this.color),
          Block(x: 5, y: 20, color: this.color),
          Block(x: 4, y: 19, color: this.color),
          Block(x: 5, y: 19, color: this.color),
        ];
      case TetroMino.I:
        return [
          Block(x: 3, y: 19, color: this.color),
          Block(x: 4, y: 19, color: this.color),
          Block(x: 5, y: 19, color: this.color),
          Block(x: 6, y: 19, color: this.color),
        ];
    }
  }
}
