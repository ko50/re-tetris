import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:re_tetris/application/controller/impl/field_controller.dart';
import 'package:re_tetris/application/controller/interface/field_controller.dart';
import 'package:re_tetris/application/usecase/operate_mino.dart';
import 'package:re_tetris/constants.dart';
import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/cordinate.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/model/minos.dart';
import 'package:re_tetris/domain/service/impl/block_validation.dart';
import 'package:re_tetris/domain/service/impl/manage_minos.dart';
import 'package:re_tetris/domain/service/impl/mobilize.dart';
import 'package:re_tetris/domain/service/impl/rotate.dart';
import 'package:re_tetris/domain/service/interface/block_validation.dart';
import 'package:re_tetris/domain/service/interface/manage_minos.dart';
import 'package:re_tetris/domain/service/interface/mobilize.dart';
import 'package:re_tetris/domain/service/interface/rotate.dart';

void main() {
  final IRotate rotate = Rotate();
  final IMobilize mobilize = Mobilize();
  final IBlockValidation validator = BlockValidation();
  final IManageMinos manageMinos = ManageMinos();
  final OperateMino minoOperator = OperateMino(rotate, mobilize, validator);

  IFieldController controller = FieldController(
    nextMinos: TetroMino.values,
    minoOperator: minoOperator,
    manageMinos: manageMinos,
  );

  setUp(() {
    controller = FieldController(
      nextMinos: TetroMino.values,
      minoOperator: minoOperator,
      manageMinos: manageMinos,
    );
  });

  test('Hold', () {
    controller
      ..lockDownMargin = 0
      ..lockDownMarginRemain = 0
      ..hold();

    expect(controller.minosInfo.canHold, false);
    expect(controller.minosInfo.holdedMino, TetroMino.T);
    expect(controller.minosInfo.operatingMino.type, TetroMino.S);
    expect(controller.minosInfo.nextMinos.length, 12);
    expect(controller.lockDownMargin, 500);
    expect(controller.lockDownMarginRemain, 15);
  });

  group('Put:', () {
    test('Put a mino', () {
      controller.put();

      expect(
        controller.placedBlocks.map((b) => b.cordinate),
        [
          Cordinate(4, 20),
          Cordinate(3, 19),
          Cordinate(4, 19),
          Cordinate(5, 19),
        ],
      );
      expect(controller.minosInfo.operatingMino.type, TetroMino.S);
      expect(
        controller.minosInfo.nextMinos,
        [
          TetroMino.Z,
          TetroMino.L,
          TetroMino.J,
          TetroMino.O,
          TetroMino.I,
        ],
      );
    });

    test('Clear a line', () {
      controller.placedBlocks = [
        Block(x: 0, y: 0, color: Colors.grey),
        Block(x: 1, y: 0, color: Colors.grey),
        Block(x: 2, y: 0, color: Colors.grey),
        Block(x: 6, y: 0, color: Colors.grey),
        Block(x: 7, y: 0, color: Colors.grey),
        Block(x: 8, y: 0, color: Colors.grey),
        Block(x: 9, y: 0, color: Colors.grey),
      ];
      controller.move(MoveDirection.Up);

      expect(
        controller.placedBlocks.map((b) => b.cordinate),
        [Cordinate(4, 0)],
      );
    });
  });

  group('Tick:', () {
    test('onTick', () {
      controller.onTick(0);

      expect(
        controller.minosInfo.operatingMino.cornerCordinate,
        Cordinate(3, 19),
      );
    });

    test('onTick when mino is touching on floor', () {
      for (int i = 0; i < FIELD_HEIGHT; i++) controller.onTick(0);

      expect(
        controller.minosInfo.operatingMino.blocks.map((b) => b.cordinate),
        [
          Cordinate(4, 1),
          Cordinate(3, 0),
          Cordinate(4, 0),
          Cordinate(5, 0),
        ],
      );

      for (int i = 0; i < 32; i++) controller.onTick(0);
      expect(controller.minosInfo.operatingMino.type, TetroMino.S);
      expect(
        controller.placedBlocks.map((b) => b.cordinate),
        [
          Cordinate(4, 1),
          Cordinate(3, 0),
          Cordinate(4, 0),
          Cordinate(5, 0),
        ],
      );
    });
  });
}
