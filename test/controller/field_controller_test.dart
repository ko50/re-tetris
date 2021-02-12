import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:re_tetris/application/controller/impl/field_controller.dart';
import 'package:re_tetris/application/usecase/operate_mino.dart';
import 'package:re_tetris/constants.dart';
import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/cordinate.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/model/waiting_mino_info.dart';
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
  final OperateMino minoOperator = OperateMino(rotate, mobilize, validator);

  FieldController controller = FieldController(minoOperator: minoOperator);

  setUp(() {
    WaitingMinoInfo waitingMinoInfo = WaitingMinoInfo(nextMinos: [
      TetroMino.S,
      TetroMino.Z,
      TetroMino.L,
      TetroMino.J,
      TetroMino.O,
      TetroMino.I,
    ]);
    controller = FieldController(minoOperator: minoOperator)
      ..waitingMinoInfo = waitingMinoInfo
      ..operatingMino = Mino(TetroMino.T);
  });

  group('Hold:', () {
    test('You can hold', () {
      expect(controller.waitingMinoInfo.canHold, true);
    });

    test('Hold onece', () {
      controller.hold();

      expect(
        controller.waitingMinoInfo.canHold,
        false,
        reason: ': Can\'t hold after hold',
      );
      expect(
        controller.waitingMinoInfo.holdedMino,
        TetroMino.T,
        reason: ': Holded mino is previous operated mino',
      );
      expect(
        controller.operatingMino.type,
        TetroMino.S,
        reason: ': Operating mino is first of next minos',
      );
      expect(
        controller.waitingMinoInfo.nextMinos,
        [
          TetroMino.Z,
          TetroMino.L,
          TetroMino.J,
          TetroMino.O,
          TetroMino.I,
        ],
        reason: ': Next minos what after hold',
      );
    });

    test('Hold twice', () {
      controller..hold();

      expect(
        controller.waitingMinoInfo.canHold,
        false,
        reason: ': Can\'t hold after hold',
      );

      controller..hold();

      expect(
        controller.waitingMinoInfo.holdedMino,
        TetroMino.T,
        reason: ': Holded mino is still holded at first',
      );
      expect(
        controller.operatingMino.type,
        TetroMino.S,
        reason: ': Operating mino is first of next minos',
      );
      expect(
        controller.waitingMinoInfo.nextMinos,
        [
          TetroMino.Z,
          TetroMino.L,
          TetroMino.J,
          TetroMino.O,
          TetroMino.I,
        ],
        reason: ': Next minos what after hold',
      );
    });
  });

  group('Put:', () {
    test('Put a mino', () {
      controller.putMino();

      expect(
        controller.placedBlocks.map((b) => b.cordinate),
        [
          Cordinate(4, 20),
          Cordinate(3, 19),
          Cordinate(4, 19),
          Cordinate(5, 19),
        ],
      );
      expect(controller.operatingMino.type, TetroMino.S);
      expect(controller.waitingMinoInfo.canHold, true);
      expect(
        controller.waitingMinoInfo.nextMinos,
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
      controller.putMino();

      expect(
        controller.placedBlocks,
        [
          Block(x: 4, y: 0, color: Colors.grey),
        ],
      );
    });
  });

  group('Tick:', () {
    test('onTick', () {
      controller.onTick();

      expect(
        controller.operatingMino.cornerCordinate,
        Cordinate(3, 19),
      );
    });

    test('onTick when mino is touching on floor', () {
      for (int i = 0; i < FIELD_HEIGHT; i++) controller.onTick();

      expect(
        controller.operatingMino.cornerCordinate,
        Cordinate(3, 1),
      );

      for (int i = 0; i < 5; i++) controller.onTick();

      expect(
        controller.operatingMino,
        TetroMino.S,
      );
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
