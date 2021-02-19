import 'dart:async';

import 'package:flutter/material.dart';

import 'package:re_tetris/application/controller/interface/field_controller.dart';
import 'package:re_tetris/constants.dart';
import 'package:re_tetris/domain/enum/direction.dart';
import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/model/cordinate.dart';

class SinglePlayPresenter {
  ValueNotifier<List<Block>> blocksState;
  ValueNotifier<TetroMino?> holdState;
  ValueNotifier<List<TetroMino>> nextState;

  IFieldController controller;

  Timer timer;

  SinglePlayPresenter(this.controller)
      : this.blocksState = ValueNotifier([]),
        this.holdState = ValueNotifier(controller.minosInfo.holdedMino),
        this.nextState = ValueNotifier(controller.minosInfo.nextMinos),
        this.timer = Timer.periodic(
            GAME_DURATION, (timer) => controller.onTick(timer.tick * 100));

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
    holdState.value = controller.minosInfo.holdedMino;
  }

  void move(MoveDirection direction) {
    controller.move(direction);
    blocksState.value = _assignAllBlocks();
  }

  void rotate(RotateDirection direction) {
    controller.rotate(direction);
    blocksState.value = _assignAllBlocks();
  }
}
