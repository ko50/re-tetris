import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:re_tetris/application/controller/impl/field_controller.dart';

class HoldButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      color: Colors.grey[900],
      child: GestureDetector(
        onTap: () => context.read<FieldController>().hold(),
        child: Icon(
          Icons.arrow_drop_down_circle_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
