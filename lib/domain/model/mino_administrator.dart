import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/mino.dart';

class MinoAdministrator {
  List<TetroMino> nextMinos;
  TetroMino? holdedMino;
  late Mino operatingMino;
  bool canHold = true;

  MinoAdministrator({required this.nextMinos});

  MinoAdministrator.from(MinoAdministrator info)
      : this.nextMinos = List.from(info.nextMinos),
        this.holdedMino = info.holdedMino,
        this.canHold = info.canHold,
        this.operatingMino = Mino.from(info.operatingMino);
}
