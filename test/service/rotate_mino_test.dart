import 'package:flutter_test/flutter_test.dart';

import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/model/cordinate.dart';
import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/service/impl/rotate.dart';

void main() {
  final Rotate rotate = Rotate();

  late List<List<int>> convertedPlacement, rotatedPlacement;
  Direction rotatedDirection;
  List<Block> rotatedBlocks;

  group('Test to convert data and rotate T mino to right', () {
    final Mino mino = Mino(TetroMino.T);
    Direction rotatedDirectionSample = Direction.East;
    List<List<int>> placementSample, rotatedPlacementSample;
    List<Cordinate> rotatedBlockCordinatesSample;
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
          RotateDirection.Right,
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
          rotatedBlockCordinatesSample.map((c) => c.x).toList(),
          rotatedBlocks.map((b) => b.cordinate.x).toList(),
        );
        expect(
          rotatedBlockCordinatesSample.map((c) => c.y).toList(),
          rotatedBlocks.map((b) => b.cordinate.y).toList(),
        );
      },
    );
  });

  group('Test to Rotate other special minos to right', () {
    final Mino iMino = Mino(TetroMino.I);
    List<List<int>> rotatedPlacementSample = [
      [0, 0, 1, 0],
      [0, 0, 1, 0],
      [0, 0, 1, 0],
      [0, 0, 1, 0],
    ];
    test('Rotate I mino to right', () {
      rotatedPlacement = rotate.rotate(
        rotate.convertBlocks(iMino),
        RotateDirection.Right,
      );
      expect(rotatedPlacementSample, rotatedPlacement);
    });

    final Mino oMino = Mino(TetroMino.O);
    rotatedPlacementSample = [
      [0, 0, 0],
      [0, 1, 1],
      [0, 1, 1],
    ];
    test('Rotate O mino to right', () {
      rotatedPlacement = rotate.rotate(
        rotate.convertBlocks(oMino),
        RotateDirection.Right,
      );
      expect(rotatedPlacementSample, rotatedPlacement);
    });
  });

  test('Rotate to Left', () {
    final Mino mino = Mino(TetroMino.T);
    List<List<int>> rotatedPlacementSample = [
      [0, 1, 0],
      [1, 1, 0],
      [0, 1, 0],
    ];
    rotatedPlacement = rotate.rotate(
      rotate.convertBlocks(mino),
      RotateDirection.Right,
    );

    expect(rotatedPlacementSample, rotatedPlacement);
  });
}
