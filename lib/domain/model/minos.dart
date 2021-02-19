import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/mino.dart';

class Minos {
  List<TetroMino> nextMinos;
  TetroMino? holdedMino;
  Mino operatingMino;
  bool canHold = true;

  Minos({required List<TetroMino> nextMinos})
      : this.operatingMino = Mino(nextMinos.first),
        this.nextMinos = nextMinos.sublist(1);

  Minos.from(Minos info)
      : this.nextMinos = [...info.nextMinos],
        this.holdedMino = info.holdedMino,
        this.canHold = info.canHold,
        this.operatingMino = Mino.from(info.operatingMino);
}
