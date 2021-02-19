import 'package:re_tetris/domain/model/minos.dart';

abstract class IManageMinos {
  Minos supplyNextMinos(Minos current);

  Minos holdMino(Minos current);

  Minos putMino(Minos current);
}
