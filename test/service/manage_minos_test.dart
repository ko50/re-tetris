import 'package:flutter_test/flutter_test.dart';
import 'package:re_tetris/domain/enum/tetromino.dart';
import 'package:re_tetris/domain/model/mino_administrator.dart';
import 'package:re_tetris/domain/service/impl/manage_minos.dart';

void main() {
  final ManageMinos manageMinos = ManageMinos();

  final List<TetroMino> nextMinos = TetroMino.values;
  MinoAdministrator minoAdministrator = MinoAdministrator(nextMinos: nextMinos);

  setUp(() {
    minoAdministrator = MinoAdministrator(nextMinos: nextMinos);
  });

  test('Default state', () {
    expect(minoAdministrator.canHold, true);
    expect(minoAdministrator.holdedMino, null);
    expect(minoAdministrator.operatingMino.type, TetroMino.T);
    expect(minoAdministrator.nextMinos, TetroMino.values);
  });

  group('Supply next minos:', () {
    test('Next minos remains over 6', () {
      minoAdministrator.nextMinos = TetroMino.values;
      minoAdministrator = manageMinos.supplyNextMinos(minoAdministrator);

      expect(minoAdministrator.nextMinos.length, 7);
    });

    test('Next minos remain fewer 6', () {
      minoAdministrator.nextMinos = TetroMino.values.sublist(3);
      minoAdministrator = manageMinos.supplyNextMinos(minoAdministrator);

      expect(minoAdministrator.nextMinos.length, 11);
    });
  });

  group('Hold mino:', () {
    group('Hold when holdedMino is null:', () {
      test('Hold when you can hold', () {
        minoAdministrator = manageMinos.holdMino(minoAdministrator);

        expect(minoAdministrator.canHold, false);
        expect(minoAdministrator.holdedMino, TetroMino.T);
        expect(minoAdministrator.operatingMino.type, TetroMino.S);
        expect(minoAdministrator.nextMinos, TetroMino.values.sublist(2));
      });

      test('Hold when you can\'t hold', () {
        minoAdministrator.canHold = false;
        minoAdministrator = manageMinos.holdMino(minoAdministrator);

        expect(minoAdministrator.canHold, false);
        expect(minoAdministrator.holdedMino, null);
        expect(minoAdministrator.operatingMino.type, TetroMino.T);
        expect(minoAdministrator.nextMinos, TetroMino.values.sublist(1));
      });
    });

    group('Hold when holdedMino is not null:', () {
      test('Hold when you can hold', () {
        minoAdministrator.holdedMino = TetroMino.O;
        minoAdministrator = manageMinos.holdMino(minoAdministrator);

        expect(minoAdministrator.canHold, false);
        expect(minoAdministrator.holdedMino, TetroMino.T);
        expect(minoAdministrator.operatingMino.type, TetroMino.O);
        expect(minoAdministrator.nextMinos, TetroMino.values.sublist(1));
      });

      test('Hold when you can\'t hold', () {
        minoAdministrator.holdedMino = TetroMino.O;
        minoAdministrator.canHold = false;
        minoAdministrator = manageMinos.holdMino(minoAdministrator);

        expect(minoAdministrator.canHold, false);
        expect(minoAdministrator.holdedMino, TetroMino.O);
        expect(minoAdministrator.operatingMino.type, TetroMino.T);
        expect(minoAdministrator.nextMinos, TetroMino.values.sublist(1));
      });
    });
  });

  test('Put mino:', () {
    minoAdministrator.canHold = false;
    minoAdministrator = manageMinos.putMino(minoAdministrator);

    expect(minoAdministrator.canHold, true);
    expect(minoAdministrator.holdedMino, null);
    expect(minoAdministrator.operatingMino.type, TetroMino.S);
    expect(minoAdministrator.nextMinos, TetroMino.values.sublist(2));
  });
}
