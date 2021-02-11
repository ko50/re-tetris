import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/cordinate.dart';

enum RotatePattern {
  NtoE,
  EtoS,
  StoW,
  WtoN,
  NtoW,
  WtoS,
  StoE,
  EtoN,
}

extension SRS on RotatePattern {
  List<Cordinate> srsShiftCandidates(TetroMino minoType) {
    if (minoType == TetroMino.I)
      switch (this) {
        case RotatePattern.NtoE:
          return [
            Cordinate(0, 0),
            Cordinate(-2, 0),
            Cordinate(1, 0),
            Cordinate(-2, -1),
            Cordinate(1, 2),
          ];
        case RotatePattern.EtoN:
          return [
            Cordinate(0, 0),
            Cordinate(2, 0),
            Cordinate(-1, 0),
            Cordinate(2, 1),
            Cordinate(-1, -2),
          ];
        case RotatePattern.EtoS:
          return [
            Cordinate(0, 0),
            Cordinate(-1, 0),
            Cordinate(2, 0),
            Cordinate(-1, 2),
            Cordinate(2, -1),
          ];
        case RotatePattern.StoE:
          return [
            Cordinate(0, 0),
            Cordinate(1, 0),
            Cordinate(-2, 0),
            Cordinate(1, -2),
            Cordinate(-2, 1),
          ];
        case RotatePattern.StoW:
          return [
            Cordinate(0, 0),
            Cordinate(2, 0),
            Cordinate(-1, 0),
            Cordinate(2, 1),
            Cordinate(-1, -2),
          ];
        case RotatePattern.WtoS:
          return [
            Cordinate(0, 0),
            Cordinate(1, 0),
            Cordinate(-2, 0),
            Cordinate(-2, -1),
            Cordinate(1, 2),
          ];
        case RotatePattern.WtoN:
          return [
            Cordinate(0, 0),
            Cordinate(-2, 0),
            Cordinate(1, 0),
            Cordinate(1, -2),
            Cordinate(-2, 1),
          ];
        case RotatePattern.NtoW:
          return [
            Cordinate(0, 0),
            Cordinate(-1, 0),
            Cordinate(2, 0),
            Cordinate(-1, 2),
            Cordinate(2, -1),
          ];
      }

    switch (this) {
      case RotatePattern.NtoE:
        return [
          Cordinate(0, 0),
          Cordinate(-1, 0),
          Cordinate(-1, 1),
          Cordinate(0, -2),
          Cordinate(-1, -2),
        ];
      case RotatePattern.EtoN:
        return [
          Cordinate(0, 0),
          Cordinate(1, 0),
          Cordinate(1, -1),
          Cordinate(0, 2),
          Cordinate(1, 2),
        ];
      case RotatePattern.EtoS:
        return [
          Cordinate(0, 0),
          Cordinate(1, 0),
          Cordinate(1, -1),
          Cordinate(0, 2),
          Cordinate(1, 2),
        ];
      case RotatePattern.StoE:
        return [
          Cordinate(0, 0),
          Cordinate(-1, 0),
          Cordinate(-1, 1),
          Cordinate(0, -2),
          Cordinate(-1, -2),
        ];
      case RotatePattern.StoW:
        return [
          Cordinate(0, 0),
          Cordinate(1, 0),
          Cordinate(1, 1),
          Cordinate(0, -2),
          Cordinate(1, -2),
        ];
      case RotatePattern.WtoS:
        return [
          Cordinate(0, 0),
          Cordinate(-1, 0),
          Cordinate(-1, -2),
          Cordinate(0, 2),
          Cordinate(-1, 2),
        ];
      case RotatePattern.WtoN:
        return [
          Cordinate(0, 0),
          Cordinate(-2, 0),
          Cordinate(-2, -1),
          Cordinate(0, 2),
          Cordinate(-1, 2),
        ];
      case RotatePattern.NtoW:
        return [
          Cordinate(0, 0),
          Cordinate(1, 0),
          Cordinate(1, 1),
          Cordinate(0, -2),
          Cordinate(1, -2),
        ];
    }
  }
}
