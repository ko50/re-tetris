import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/minos.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/service/interface/manage_minos.dart';

class ManageMinos implements IManageMinos {
  Minos supplyNextMinos(Minos current) {
    if (current.nextMinos.length >= 6) return current;

    return current..nextMinos.addAll(List.from(TetroMino.values)..shuffle());
  }

  Minos holdMino(Minos current) {
    if (!current.canHold) return current;

    Minos modified = Minos.from(current);

    modified.holdedMino = current.operatingMino.type;
    modified.operatingMino = Mino(current.holdedMino ?? current.nextMinos[0]);

    if (current.holdedMino == null) modified.nextMinos.removeAt(0);
    modified.canHold = false;
    modified = supplyNextMinos(modified);

    return modified;
  }

  Minos putMino(Minos current) {
    Minos modified = Minos.from(current);

    modified.operatingMino = Mino(modified.nextMinos[0]);
    modified.nextMinos.removeAt(0);

    modified = supplyNextMinos(modified);
    modified.canHold = true;

    return modified;
  }
}
