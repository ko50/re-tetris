import 'package:re_tetris/domain/enum/tetromino.dart';

class WaitingMinoInfo {
  List<TetroMino> nextMinos;
  TetroMino? holdedMino;
  bool canHold = true;

  WaitingMinoInfo({required this.nextMinos});
}
