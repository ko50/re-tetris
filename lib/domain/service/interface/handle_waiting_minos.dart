import 'package:re_tetris/domain/model/mino.dart';
import 'package:re_tetris/domain/model/waiting_mino_info.dart';

abstract class HandleWaitingMinos {
  WaitingMinoInfo holdMino();

  Mino refresh(Mino mino);
}
