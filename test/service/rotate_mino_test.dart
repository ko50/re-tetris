import 'package:flutter_test/flutter_test.dart';

import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/model/cordinate.dart';
import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/service/impl/rotate.dart';

void main() {
  final Rotate rotate = Rotate();

  final Mino tMino = Mino(TetroMino.T),
      iMino = Mino(TetroMino.I),
      oMino = Mino(TetroMino.O);

  List<List<int>> convertedPlacement, rotatedPlacement;
  Direction rotatedDirection;
  List<Block> rotatedBlocks;

  group('Convert data:', () {
    convertedPlacement = rotate.convertBlocks(tMino);
    rotatedPlacement = rotate.rotatePlacement(convertedPlacement);

    test('Convert blocks to placement', () {
      expect(
        convertedPlacement,
        [
          [0, 1, 0],
          [1, 1, 1],
          [0, 0, 0],
        ],
      );
    });

    test('Rotate placement right', () {
      expect(
        rotatedPlacement,
        [
          [0, 1, 0],
          [0, 1, 1],
          [0, 1, 0],
        ],
      );
    });

    test('Change direction of mino', () {
      rotatedDirection = rotate.changeDirection(
        tMino.direction,
        RotateDirection.Right,
      );

      expect(rotatedDirection, Direction.East);
    });

    test('Convert rotated placement to block list', () {
      rotatedBlocks = rotate.convertPlacement(
        rotatedPlacement,
        tMino.type.color,
        tMino.cornerCordinate,
      );
      final List<Cordinate> sample = [
        Cordinate(4, 20),
        Cordinate(4, 19),
        Cordinate(5, 19),
        Cordinate(4, 18),
      ];

      for (int i = 0; i < rotatedBlocks.length; i++)
        assert(rotatedBlocks[i].cordinate == sample[i]);
    });
  });

  group('Rotate minos to right:', () {
    test('Rotate I mino', () {
      rotatedPlacement = rotate.rotatePlacement(rotate.convertBlocks(iMino));

      expect(
        rotatedPlacement,
        [
          [0, 0, 1, 0],
          [0, 0, 1, 0],
          [0, 0, 1, 0],
          [0, 0, 1, 0],
        ],
      );
    });

    test('Rotate O mino', () {
      rotatedPlacement = rotate.rotatePlacement(rotate.convertBlocks(oMino));

      expect(
        rotatedPlacement,
        [
          [1, 1],
          [1, 1],
        ],
      );
    });
  });
}
