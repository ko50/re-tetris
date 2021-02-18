import 'package:re_tetris/domain/model/mino_administrator.dart';

abstract class IManageMinos {
  MinoAdministrator supplyNextMinos(MinoAdministrator current);

  MinoAdministrator holdMino(MinoAdministrator current);

  MinoAdministrator putMino(MinoAdministrator current);
}
