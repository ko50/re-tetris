import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:re_tetris/view/presenter/single_play.dart';

final singlePlayPresenter =
    Provider<SinglePlayPresenter>((ref) => SinglePlayPresenter());

final blocksState =
    ChangeNotifierProvider((ref) => ref.watch(singlePlayPresenter).blocksState);

final holdState =
    ChangeNotifierProvider((ref) => ref.watch(singlePlayPresenter).holdState);

final nextState =
    ChangeNotifierProvider((ref) => ref.watch(singlePlayPresenter).nextState);
