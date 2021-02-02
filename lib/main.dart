import 'package:flutter/material.dart';

import 'package:re_tetris/view/page/play.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tetris',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Play(),
    );
  }
}
