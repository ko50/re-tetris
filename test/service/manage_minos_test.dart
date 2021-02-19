import 'package:flutter_test/flutter_test.dart';
import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/minos.dart';
import 'package:re_tetris/domain/service/impl/manage_minos.dart';

void main() {
  final ManageMinos manageMinos = ManageMinos();

  final List<TetroMino> nextMinos = TetroMino.values;
  Minos minosInfo = Minos(nextMinos: nextMinos);

  setUp(() {
    minosInfo = Minos(nextMinos: nextMinos);
  });

  test('Default state', () {
    expect(minosInfo.canHold, true);
    expect(minosInfo.holdedMino, null);
    expect(minosInfo.operatingMino.type, TetroMino.T);
    expect(minosInfo.nextMinos, TetroMino.values.sublist(1));
  });

  group('Supply next minos:', () {
    test('Next minos remains over 6', () {
      minosInfo.nextMinos = TetroMino.values;
      minosInfo = manageMinos.supplyNextMinos(minosInfo);

      expect(minosInfo.nextMinos.length, 7);
    });

    test('Next minos remains fewer 6', () {
      minosInfo.nextMinos = TetroMino.values.sublist(3);
      minosInfo = manageMinos.supplyNextMinos(minosInfo);

      expect(minosInfo.nextMinos.length, 11);
    });
  });

  group('Hold mino:', () {
    group('Hold when holdedMino is null:', () {
      test('Hold when you can hold', () {
        minosInfo = manageMinos.holdMino(minosInfo);

        expect(minosInfo.canHold, false);
        expect(minosInfo.holdedMino, TetroMino.T);
        expect(minosInfo.operatingMino.type, TetroMino.S);
        expect(minosInfo.nextMinos.length, 12);
      });

      test('Hold when you can\'t hold', () {
        minosInfo.canHold = false;
        minosInfo = manageMinos.holdMino(minosInfo);

        expect(minosInfo.canHold, false);
        expect(minosInfo.holdedMino, null);
        expect(minosInfo.operatingMino.type, TetroMino.T);
        expect(minosInfo.nextMinos.length, 6);
      });
    });

    group('Hold when holdedMino is not null:', () {
      test('Hold when you can hold', () {
        minosInfo.holdedMino = TetroMino.O;
        minosInfo = manageMinos.holdMino(minosInfo);

        expect(minosInfo.canHold, false);
        expect(minosInfo.holdedMino, TetroMino.T);
        expect(minosInfo.operatingMino.type, TetroMino.O);
        expect(minosInfo.nextMinos.length, 6);
      });

      test('Hold when you can\'t hold', () {
        minosInfo.holdedMino = TetroMino.O;
        minosInfo.canHold = false;
        minosInfo = manageMinos.holdMino(minosInfo);

        expect(minosInfo.canHold, false);
        expect(minosInfo.holdedMino, TetroMino.O);
        expect(minosInfo.operatingMino.type, TetroMino.T);
        expect(minosInfo.nextMinos.length, 6);
      });
    });
  });

  test('Put mino:', () {
    minosInfo.canHold = false;
    minosInfo = manageMinos.putMino(minosInfo);

    expect(minosInfo.canHold, true);
    expect(minosInfo.holdedMino, null);
    expect(minosInfo.operatingMino.type, TetroMino.S);
    expect(minosInfo.nextMinos.length, 5);
  });
}
