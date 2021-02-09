import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/model/cordinate.dart';
import 'package:test/test.dart';

import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/service/impl/rotate.dart';

void main() {
  final Rotate rotate = Rotate();

  RotateDirection rotateDirection = RotateDirection.Right;
  Direction rotatedDirectionSample = Direction.East;

  List<List<int>> placementSample, rotatedPlacementSample;
  List<Cordinate> rotatedBlockCordinatesSample;
  Mino mino;

  late List<List<int>> convertedPlacement, rotatedPlacement;
  Direction rotatedDirection;
  List<Block> rotatedBlocks;

  group('Test of Rotation of T mino', () {
    mino = Mino(TetroMino.T);
    placementSample = [
      [0, 1, 0],
      [1, 1, 1],
      [0, 0, 0],
    ];
    rotatedPlacementSample = [
      [0, 1, 0],
      [0, 1, 1],
      [0, 1, 0],
    ];
    rotatedBlockCordinatesSample = [
      Cordinate(4, 20),
      Cordinate(3, 19),
      Cordinate(4, 19),
      Cordinate(5, 19),
    ];

    test(
      'Convert blocks to mino placement',
      () {
        convertedPlacement = rotate.convertBlocks(mino);
        expect(placementSample, convertedPlacement);
      },
    );

    test(
      'Rotate placement right',
      () {
        rotatedPlacement = rotate.rotate(
          convertedPlacement,
          RotateDirection.Right,
        );
        expect(rotatedPlacementSample, rotatedPlacement);
      },
    );

    test(
      'Change direction of mino',
      () {
        rotatedDirection = rotate.changeDirection(
          mino.direction,
          rotateDirection,
        );
        expect(rotatedDirectionSample, rotatedDirection);
      },
    );

    test(
      'Convert rotated placement to block list',
      () {
        rotatedBlocks = rotate.convertPlacement(
          rotatedPlacement,
          mino.type.color,
          mino.cornerCordinate,
        );
        expect(
          rotatedBlockCordinatesSample,
          rotatedBlocks.map((b) => b.cordinate),
        );
      },
    );
  });
}
