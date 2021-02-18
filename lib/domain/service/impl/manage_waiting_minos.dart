import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/mino_administrator.dart';
import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/service/interface/manage_waiting_minos.dart';

class ManageMinos implements IManageMinos {
  MinoAdministrator supplyNextMinos(MinoAdministrator current) {
    if (current.nextMinos.length >= 6) return current;

    return current..nextMinos.addAll(List.from(TetroMino.values)..shuffle());
  }

  MinoAdministrator holdMino(MinoAdministrator info) {
    if (!info.canHold) return info;

    MinoAdministrator modified = MinoAdministrator.from(info);

    modified.holdedMino = info.operatingMino.type;
    modified.operatingMino = Mino(info.holdedMino ?? info.nextMinos.first);
    modified.operatingMino = Mino(info.nextMinos.first);
    modified.nextMinos.removeAt(0);

    modified.canHold = false;
    modified = supplyNextMinos(modified);

    return modified;
  }

  MinoAdministrator putMino(MinoAdministrator current) {
    MinoAdministrator modified = MinoAdministrator.from(current);

    modified.operatingMino = Mino(modified.nextMinos.first);
    modified.nextMinos.removeAt(0);

    modified.canHold = true;

    return modified;
  }
}
