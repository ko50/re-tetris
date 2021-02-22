import 'package:re_tetris/domain/enum/rotate_pattern.dart';

enum Direction { North, East, South, West }

enum RotateDirection { Right, Left }

enum MoveDirection { Left, Up, Right, Down }

extension Pattern on Direction {
  RotatePattern rotatePattern(RotateDirection direction) {
    if (direction == RotateDirection.Right) {
      switch (this) {
        case Direction.North:
          return RotatePattern.NtoE;
        case Direction.East:
          return RotatePattern.EtoS;
        case Direction.South:
          return RotatePattern.StoW;
        case Direction.West:
          return RotatePattern.WtoN;
      }
    }

    switch (this) {
      case Direction.North:
        return RotatePattern.NtoW;
      case Direction.East:
        return RotatePattern.EtoN;
      case Direction.South:
        return RotatePattern.StoE;
      case Direction.West:
        return RotatePattern.WtoS;
    }
  }
}
