import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:re_tetris/constants.dart';

import 'package:re_tetris/domain/model/block.dart';
import 'package:re_tetris/domain/service/impl/block_validation.dart';

void main() {
  final BlockValidation validator = BlockValidation();

  late Block stackedBlock,
      unstackedblock,
      overRightBlock,
      overLeftBlock,
      overUnderBlock;
  late List<Block> placedBlocks;

  bool result;

  setUp(() {
    stackedBlock = Block(x: 0, y: 0, color: Colors.red);
    unstackedblock = Block(x: 1, y: 1, color: Colors.blue);
    overRightBlock = Block(x: FIELD_WIDTH, y: 0, color: Colors.red);
    overLeftBlock = Block(x: -1, y: 0, color: Colors.red);
    overUnderBlock = Block(x: 0, y: -1, color: Colors.red);
    placedBlocks = [stackedBlock];
  });

  test('Validate stacked block', () {
    result = validator.canPutBlock(stackedBlock, placedBlocks);
    expect(result, false);
  });

  test('Validate unstacked block', () {
    result = validator.canPutBlock(unstackedblock, placedBlocks);
    expect(result, true);
  });

  test('Validate over right block', () {
    result = validator.canPutBlock(overRightBlock, placedBlocks);
    expect(result, false);
  });

  test('Validate over left block', () {
    result = validator.canPutBlock(overLeftBlock, placedBlocks);
    expect(result, false);
  });

  test('Validate over under block', () {
    result = validator.canPutBlock(overUnderBlock, placedBlocks);
    expect(result, false);
  });
}
