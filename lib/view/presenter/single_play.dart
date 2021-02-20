import 'dart:async';

import 'package:flutter/material.dart';

import 'package:re_tetris/application/controller/impl/field_controller.dart';
import 'package:re_tetris/application/controller/interface/field_controller.dart';
import 'package:re_tetris/application/usecase/operate_mino.dart';
import 'package:re_tetris/constants.dart';
import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/cordinate.dart';
import 'package:re_tetris/domain/service/impl/block_validation.dart';
import 'package:re_tetris/domain/service/impl/manage_minos.dart';
import 'package:re_tetris/domain/service/impl/mobilize.dart';
import 'package:re_tetris/domain/service/impl/rotate.dart';

class SinglePlayPresenter {
  ValueNotifier<List<Block>> blocksState = ValueNotifier([]);
  ValueNotifier<List<Block>> holdState = ValueNotifier([]);
  ValueNotifier<List<List<Block>>> nextState = ValueNotifier([]);

  IFieldController controller = FieldController(
    nextMinos: TetroMino.values..shuffle(),
    manageMinos: ManageMinos(),
    minoOperator: OperateMino(
      Rotate(),
      Mobilize(),
      BlockValidation(),
    ),
  );

  late Timer timer;

  SinglePlayPresenter() {
    holdState.value = _tetroMinoToBlock(controller.minosInfo.holdedMino);
    nextState.value = controller.minosInfo.nextMinos
        .map((mino) => _tetroMinoToBlock(mino))
        .toList();

    timer = Timer.periodic(GAME_DURATION, (timer) {
      controller.onTick(timer.tick * 100);
      nextState.value = controller.minosInfo.nextMinos
          .map((mino) => _tetroMinoToBlock(mino))
          .toList();
    });
  }

  List<Block> _tetroMinoToBlock(TetroMino? tetroMino) {
    if (tetroMino == null) return [];

    List<Block> blocks = [];

    for (Block block in tetroMino.initialPlacement) {
      blocks.add(
        Block(
          x: block.cordinate.x - 3,
          y: block.cordinate.y - 19,
          color: block.color,
        ),
      );
    }

    return blocks;
  }

  List<Block> _assignAllBlocks() {
    List<Block> blocks = [
          ...controller.placedBlocks,
          ...controller.minosInfo.operatingMino.blocks,
        ],
        filled = [];

    for (int y = 0; y < FIELD_HEIGHT; y++) {
      for (int x = 0; x < FIELD_WIDTH; x++) {
        filled.add(
          blocks.firstWhere(
            (b) => b.cordinate == Cordinate(x, y),
            orElse: () => Block(x: x, y: y, color: Colors.black),
          ),
        );
      }
    }

    return filled;
  }

  void hold() {
    controller.hold();
    blocksState.value = _assignAllBlocks();
    holdState.value = _tetroMinoToBlock(controller.minosInfo.holdedMino);
    nextState.value = controller.minosInfo.nextMinos
        .map((mino) => _tetroMinoToBlock(mino))
        .toList();
  }

  void move(MoveDirection direction) {
    controller.move(direction);
    blocksState.value = _assignAllBlocks();
    nextState.value = controller.minosInfo.nextMinos
        .map((mino) => _tetroMinoToBlock(mino))
        .toList();
  }

  void rotate(RotateDirection direction) {
    controller.rotate(direction);
    blocksState.value = _assignAllBlocks();
  }
}
