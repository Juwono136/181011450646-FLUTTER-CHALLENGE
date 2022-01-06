import 'package:flutter/material.dart';

class LevelIndicator extends StatelessWidget {
  const LevelIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            value: 23,
            valueColor: AlwaysStoppedAnimation(Colors.green)),
      ),
    );
  }
}