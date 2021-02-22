import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:re_tetris/application/usecase/operate_mino.dart';
import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/cordinate.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/service/impl/block_validation.dart';
import 'package:re_tetris/domain/service/impl/mobilize.dart';
import 'package:re_tetris/domain/service/impl/rotate.dart';
import 'package:re_tetris/domain/service/interface/block_validation.dart';
import 'package:re_tetris/domain/service/interface/mobilize.dart';
import 'package:re_tetris/domain/service/interface/rotate.dart';

void main() {
  final IRotate rotate = Rotate();
  final IMobilize mobilize = Mobilize();
  final IBlockValidation validator = BlockValidation();
  final OperateMino operateMino = OperateMino(rotate, mobilize, validator);

  late Mino mino = Mino(TetroMino.T);
  final List<Block> placedBlocks = [
    Block(x: 0, y: 4, color: Colors.grey),
    Block(x: 1, y: 0, color: Colors.grey),
    Block(x: 2, y: 1, color: Colors.grey),
    Block(x: 1, y: 2, color: Colors.grey),
    Block(x: 2, y: 0, color: Colors.grey),
    Block(x: 2, y: 2, color: Colors.grey),
  ];

  Mino operatedMino;

  setUp(() {
    mino.blocks = mino.type.initialPlacement;
    mino.cornerCordinate = Cordinate(3, 20);
  });

  group('Mobilize:', () {
    test('Move to right', () {
      operatedMino = operateMino.moveMino(
        mino,
        MoveDirection.Right,
        placedBlocks,
      );

      expect(
        operatedMino.blocks.map((b) => b.cordinate),
        [
          Cordinate(5, 20),
          Cordinate(4, 19),
          Cordinate(5, 19),
          Cordinate(6, 19),
        ],
      );
    });

    test('Move to left', () {
      operatedMino = operateMino.moveMino(
        mino,
        MoveDirection.Left,
        placedBlocks,
      );

      expect(
        operatedMino.blocks.map((b) => b.cordinate),
        [
          Cordinate(3, 20),
          Cordinate(2, 19),
          Cordinate(3, 19),
          Cordinate(4, 19),
        ],
      );
    });

    test('Down', () {
      operatedMino = operateMino.moveMino(
        mino,
        MoveDirection.Down,
        placedBlocks,
      );

      expect(
        operatedMino.blocks.map((b) => b.cordinate),
        [
          Cordinate(4, 19),
          Cordinate(3, 18),
          Cordinate(4, 18),
          Cordinate(5, 18),
        ],
      );
    });

    test('HardDrop', () {
      operatedMino = operateMino.moveMino(
        mino,
        MoveDirection.Up,
        placedBlocks,
      );

      expect(
        operatedMino.blocks.map((b) => b.cordinate),
        [
          Cordinate(4, 1),
          Cordinate(3, 0),
          Cordinate(4, 0),
          Cordinate(5, 0),
        ],
      );
    });
  });

  group('Rotate:', () {
    test('Rotate to right', () {
      operatedMino = operateMino.rotateMino(
        mino,
        RotateDirection.Right,
        placedBlocks,
      );

      expect(
        operatedMino.blocks.map((b) => b.cordinate),
        [
          Cordinate(4, 20),
          Cordinate(4, 19),
          Cordinate(5, 19),
          Cordinate(4, 18),
        ],
      );
    });

    test('Rotate to left', () {
      mino = Mino(TetroMino.Z);
      operatedMino = operateMino.rotateMino(
        mino,
        RotateDirection.Left,
        placedBlocks,
      );

      expect(
        operatedMino.blocks.map((b) => b.cordinate),
        [
          Cordinate(4, 20),
          Cordinate(3, 19),
          Cordinate(4, 19),
          Cordinate(3, 18),
        ],
      );
    });

    test('Apply srs', () {
      mino
        ..blocks = [
          Block(x: 1, y: 4, color: mino.blocks[0].color),
          Block(x: 0, y: 3, color: mino.blocks[0].color),
          Block(x: 1, y: 3, color: mino.blocks[0].color),
          Block(x: 2, y: 3, color: mino.blocks[0].color),
        ]
        ..cornerCordinate = Cordinate(0, 4);
      operatedMino = operateMino.rotateMino(
        mino,
        RotateDirection.Right,
        placedBlocks,
      );
      operatedMino = operateMino.rotateMino(
        operatedMino,
        RotateDirection.Right,
        placedBlocks,
      );

      expect(
        operatedMino.blocks.map((b) => b.cordinate),
        [
          Cordinate(0, 2),
          Cordinate(0, 1),
          Cordinate(1, 1),
          Cordinate(0, 0),
        ],
      );
    });
  });
}
