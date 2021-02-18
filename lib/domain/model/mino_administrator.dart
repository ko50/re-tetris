import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/mino.dart';

class MinoAdministrator {
  List<TetroMino> nextMinos;
  TetroMino? holdedMino;
  Mino operatingMino;
  bool canHold = true;

  MinoAdministrator({required List<TetroMino> nextMinos})
      : this.operatingMino = Mino(nextMinos.first),
        this.nextMinos = nextMinos.sublist(1);

  MinoAdministrator.from(MinoAdministrator info)
      : this.nextMinos = [...info.nextMinos],
        this.holdedMino = info.holdedMino,
        this.canHold = info.canHold,
        this.operatingMino = Mino.from(info.operatingMino);
}
