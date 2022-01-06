import 'package:flutter/material.dart';

class RowList extends StatelessWidget {
  final String name;
  final String value;

  const RowList({Key? key, required this.name, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(name),
        SizedBox(
          width: 30,
        ),
        Text(":"),
        SizedBox(
          width: 30,
        ),
        Text(value)
      ],
    );
  }
}